# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    return if user.nil?

    if user.super_admin?
      can :manage, :all
    end
  end
end
