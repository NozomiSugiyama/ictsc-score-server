# frozen_string_literal: true

class Team < ApplicationRecord
  validates :role,            presence: true
  validates :number,          presence: true, uniqueness: true
  validates :name,            presence: true, uniqueness: true
  # dummy field
  validates :password,        presence: true, length: { maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }, if: :will_save_change_to_password_digest?
  validates :password_digest, presence: true
  validates :organization,    presence: false
  validates :color,           color_code: true, allow_nil: true

  has_many :answers,               dependent: :destroy
  has_many :attachments,           dependent: :nullify
  has_many :first_correct_answers, dependent: :destroy
  has_many :issues,                dependent: :destroy
  has_many :notices,               dependent: :nullify, inverse_of: 'target_team'
  has_many :problem_environments,  dependent: :destroy

  # 値が大きいほど大体権限が高い
  enum role: {
    staff: 10,
    audience: 5,
    player: 1
  }

  attr_reader :password

  def password=(value)
    @password = value
    self.password_digest = BCrypt::Password.create(@password, cost: BCrypt::Engine.cost)
  end

  def authenticate(plain_password)
    BCrypt::Password.new(password_digest).is_password?(plain_password) && self
  end

  class << self
    def login(name:, password:)
      Team
        .find_by(name: name)
        &.authenticate(password)
    end
  end
end
