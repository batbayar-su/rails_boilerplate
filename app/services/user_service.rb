# User bolon role heseg deer hereglegdej baigaa Service class
class UserService < BaseService
  # User-n jagsaalt avah
  def self.get_user_list(page_number, per_page, show_all_users)
    list = User.select('users.*, GROUP_CONCAT(DISTINCT roles.id) role_id, GROUP_CONCAT(DISTINCT roles.name) role_names')
               .joins('LEFT JOIN users_roles on users.id = users_roles.user_id ')
               .joins('LEFT JOIN roles on users_roles.role_id = roles.id ').group('users.id').page(page_number).per(per_page)
    list = list.with_deleted if show_all_users == 1
    list
  end

  # tuhain hereglegchees hamaaraad select deer admin moderator zereg role-g haruulahgui baih uudnees hereglegdej baigaa. Jishee: user edit form
  def self.get_filtered_role_list(current_user)
    if current_user.has_role? :admin
      Role.all
    elsif current_user.has_role? :moderator
      Role.select('roles.*').where.not(name: ['Admin'])
    else
      Role.select('roles.*').where(name: current_user.roles.collect(&:name))
    end
  end

  # User-g id-r avah
  def self.find_user(id)
    User.find(id)
  end

  # User-n medeelliig update hiih
  def self.update_user(object, object_params)
    # Olon uildelt action uchir "transaction" dotor hiij ali neg hesegt aldaa garhad rollback hiihed hereglej baina.
    ActiveRecord::Base.transaction do
      object.delete_roles
      # Database-ruu role-uudaa oruulj baina
      object_params[:roles].each { |r| object.add_role(Role.find(r).name) unless r.blank? } unless object_params[:roles].nil?
      # Negentee base-d orson bolhoor roles param-g ustgaj baina. Ugui bol roles n user-tei relation-toi uchir aldaa garna
      object_params = object_params.except(:roles)
      object.update!(object_params)
    end
  end

  # User-g ustgah
  def self.delete_user(object)
    object.destroy
  end

  # User-g activate hiih
  def self.activate_user(object)
    object.restore
  end

  # Role-n jagsaalt avah
  def self.get_role_list(page_number, per_page)
    list = Role.all.page(page_number).per(per_page)
    list
  end

  # Role-g id-r avah
  def self.find_role(id)
    Role.find(id)
  end

  # Role-g update hiih
  def self.update_role(object, object_params)
    object.update!(object_params)
  end

  # Role-g ustgah
  def self.delete_role(object)
    object.destroy
  end

  # Role nemeh
  def self.create_role(role_params)
    role_params == '' ? Role.new : Role.create!(role_params)
  end

  # Role-g ustgahiin omno oor gazar hereglegdej baigaa uguig medhed hereglegdej baigaa
  def self.check_role_in_use(role_id)
    conn = ActiveRecord::Base.connection
    role_in_use = conn.execute(%(SELECT * FROM users_roles WHERE users_roles.role_id = #{conn.quote(role_id)}))
    role_in_use.size.zero?
  end

  # Google, Facebook gehmet login hiih gesen (Odoogoor zovhon Google baigaa)
  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first

    unless user
      user = User.create(provider:     auth.provider,
                         uid:          auth.uid,
                         email:        auth.info.email,
                         first_name:   auth.info.first_name,
                         last_name:    auth.info.last_name,
                         confirmed_at: Time.now,
                         password:     Devise.friendly_token[0, 20])
    end

    user
  end
end
