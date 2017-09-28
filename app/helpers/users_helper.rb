module UsersHelper
  # role-n jagsaaltaas taslalaar zaaglagdsan nersiin string gargaj avah
  def get_role_name_list(roles)
    roles.map(&:name).join(',')
  end
end
