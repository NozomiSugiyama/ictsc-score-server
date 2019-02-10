# frozen_string_literal: true

class Config < ApplicationRecord
  class CastFailed < StandardError; end

  validates :key,        presence: true, uniqueness: true
  validates :value,      presence: true, length: { maximum: 4095 }
  validates :value_type, presence: true
  validate :validate_castable
  validate :reject_update_value_type, on: :update

  # for sinatra reloader
  unless Config.methods.include?(:value_types) # なぜかmethod_defined?では反応しない
    enum value_type: {
      boolean: 10,
      integer: 20,
      string: 30,
      date: 40
    }
  end

  def validate_castable
    errors.add(:value, ' "%s" is not castable to %s' % [value, value_type]) unless self.class.castable?(self)
  end

  def reject_update_value_type
    errors.add(:value_type, 'disallow to update value_type(%s to %s)' % [value_type, value_type_was]) if will_save_change_to_value_type?
  end

  class << self
    def get(key)
      cast(find_by(key: key))
    end

    def get!(key)
      cast!(find_by!(key: key))
    end

    def set(key, value)
      find_by(key: key)&.update(value: value)
    end

    def set!(key, value)
      find_by!(key: key).update!(value: value)
    end

    def cast(record)
      return nil if record&.value_type.nil?

      case record
      when :boolean?.to_proc
        case record.value
        when 'true', '1' then true
        when 'false', '0' then false
        else nil
        end
      when :integer?.to_proc
        Integer(record.value) rescue nil
      when :string?.to_proc
        record.value
      when :date?.to_proc
        DateTime.parse(record.value) rescue nil
      else
        nil
      end
    end

    def cast!(record)
      result = cast(record)
      raise CastFailed, 'key: %s, value: "%s", value_type: %s' % [record.key, record.value, record.value_type] if result.nil?
      result
    end

    def castable?(record)
      cast(record) != nil
    end
  end
end
