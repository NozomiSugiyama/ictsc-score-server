# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :addAnswer, mutation: Mutations::AddAnswer
    field :addIssue, mutation: Mutations::AddIssue
    field :addIssueComment, mutation: Mutations::AddIssueComment
    field :addNotice, mutation: Mutations::AddNotice
    field :addProblemSupplement, mutation: Mutations::AddProblemSupplement
    field :applyCategory, mutation: Mutations::ApplyCategory
    field :applyProblem, mutation: Mutations::ApplyProblem
    field :applyProblemEnvironment, mutation: Mutations::ApplyProblemEnvironment
    field :applyScore, mutation: Mutations::ApplyScore
    field :applyTeam, mutation: Mutations::ApplyTeam
    field :confirmingAnswer, mutation: Mutations::ConfirmingAnswer
    field :deleteNotice, mutation: Mutations::DeleteNotice
    field :deleteProblemSupplement, mutation: Mutations::DeleteProblemSupplement
    field :pinNotice, mutation: Mutations::PinNotice
    field :transitionIssueState, mutation: Mutations::TransitionIssueState
  end
end
