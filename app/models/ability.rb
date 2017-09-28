# Authorization handler class
class Ability
  include CanCan::Ability

  # core action
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all # admin-d buh erhiig ogoh
      cannot :manage, Role, name: Rails.configuration.x.immune_roles # admin-g immune_roles-d baigaa role-d nolooloh erhiig hasah
      can :read, Role, name: Rails.configuration.x.immune_roles # admin-g immune_roles-d baigaa role-g harah erhiig ogoh
    else
      # moderator bol admin moderator 2-s busad User object-d nolooloh erhtei
      can :manage, User, id: User.without_role(:admin).without_role(:moderator).pluck(:id) if user.has_role? :moderator
      can :manage, User, id: user.id # Ooriihoo object-d nolooloh erhtei
      can :read, User # Buh User object-g harah erhtei
    end
  end
end
