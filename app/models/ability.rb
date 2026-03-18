# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)

    return if user.nil?

    if user.super_admin?
      can :manage, Company
      can :manage, Subscription
      can :manage, WebCompany, company_id: nil
      can :manage, Web, company_id: nil
      can :manage, Tag, company_id: nil
      can [:read, :create], User, role: [:super_admin, :company_admin]
      return
    end

    can :read, WebCompany, company_id: nil
    can :read, Web, company_id: nil
    can :read, Tag, company_id: nil
    can :manage, Credential, company_id: user.company_id

    if user.company_admin?
      cannot :create, User, role: :super_admin
      can :update, Company, id: user.company_id
      can :manage, [User, Group], company_id: user.company_id
      can :manage, WebCompany, company_id: user.company_id
      can :manage, Web, company_id: user.company_id
      can :manage, Tag, company_id: user.company_id
      return
    end

    if user.user?
      can :manage, EmergencyContact, owner_id: user.id
      can :read, EmergencyContact, contact_id: user.id
      can :read, User, company_id: user.company_id, role: :user
      can :read, GroupUser, user_id: user.id
      can :read, Group, group_users: { user_id: user.id }
      cannot :manage, WebCompany
      can :read, WebCompany
      can :read, Web

      can :create, EmergencyRequest, contact_id: user.id
    end

    can :update, User, id: user.id
  end
end
