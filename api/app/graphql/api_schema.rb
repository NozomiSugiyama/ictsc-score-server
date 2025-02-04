# frozen_string_literal: true

class ApiSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
  use(GraphQL::Batch)

  # TODO: mutationとqueryが同時に来たら事故る気がする -> できない気がする
  # TODO: mutationの想定外の例外補足
  # TODO: https://graphql-ruby.org/schema/definition.html#execution-configuration
  # max_depth 10
  # max_complexity 300
  # default_max_page_size 20
end
