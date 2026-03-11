# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)

    return if user.nil?

    if user.super_admin?
      can :manage, Company
      can :manage, Subscription
      can :manage, WebCompany
      can [:read, :create], User, role: [:super_admin, :company_admin]
      return
    end

    can :manage, Credential, company_id: user.company_id

    if user.company_admin?
      can :update, Company, id: user.company_id
      can :manage, [User, Group, Folder], company_id: user.company_id
      cannot :create, User, role: :super_admin
      return
    end

    if user.user?
      can :manage, EmergencyContact, owner_id: user.id
      can :read, EmergencyContact, contact_id: user.id
      can :read, User, company_id: user.company_id, role: :user
      can :read, GroupUser, user_id: user.id
      can :read, Group, group_users: { user_id: user.id }
      can :read, WebCompany
      can :read, Web

      can :create, EmergencyRequest, contact_id: user.id
    end

    can :update, User, id: user.id
  end
end
