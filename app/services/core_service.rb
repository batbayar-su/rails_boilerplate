# Site-n module-uudaas busad hesguuded heregleh undsen service class
class CoreService < BaseService
  # Maintenance mode-d baigaa uguig shalgah
  def self.check_state
    @maintenance = Core.where("group_id='maintenance' AND item_id='enabled'").first

    @maintenance.present? && @maintenance.item_value == '1' ? true : false
  end

  # Maintenance mode-d baihad render hiih huudas mon uguig shalgah
  def self.path_included(path)
    @setting_paths = Core.where("group_id='maintenance' AND item_id='skip_paths'").first
    if @setting_paths.present? && @setting_paths.item_value.present?
      skip_paths = @setting_paths.item_value.split(',')
    end

    skip_paths.present? && skip_paths.include?(path) ? true : false
  end

  # Maintenance mode-g switch hiih
  def self.change_state(state)
    @maintenance = Core.where("group_id='maintenance' AND item_id='enabled'").first
    if @maintenance.nil?
      @maintenance = Core.new(group_id: 'maintenance', item_id: 'enabled', item_value: '0')
      @maintenance.save!
    end

    @paths = Core.where("group_id='maintenance' AND item_id='skip_paths'").first
    if @paths.nil?
      @paths = Core.new(group_id: 'maintenance', item_id: 'skip_paths', item_value: '/maintenance,/users/sign_in,/users/sign_out')
      @paths.save!
    end

    @maintenance.item_value = if state.to_s == 'ON'
                                '1'
                              else
                                '0'
                              end
    @maintenance.save!
  end

  # User edit huudsand post code oruulhad automat-r hayagiig n avah
  def self.get_address(value)
    @post_address = PostAddress.where(postcode: value).first

    return '' if @post_address.nil?
    address = if @post_address.address_detail.to_s == '以下に掲載がない場合'
                "#{@post_address.prefectures_name}#{@post_address.address_general}"
              else
                "#{@post_address.prefectures_name}#{@post_address.address_general}#{@post_address.address_detail}"
              end

    address
  end
end
