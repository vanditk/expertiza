class PermissionFor360Degree < ActiveRecord::Migration
  def self.up
    administer_assignments_id = Permission.find_by_name("administer assignments").id
    SiteController.find_or_create_by_name(:name => 'assessment360', :permission_id => administer_assignments_id)

    controller_id = SiteController.find_by_name('users').id
    do_assignments_id = Permission.find_by_name("do assignments").id
    ['contributions', 'contributions_new'].each do |action|
      unless ControllerAction.find_by_site_controller_id_and_name(controller_id, action)
        ControllerAction.create :site_controller_id => controller_id, :name => action, :permission_id => do_assignments_id, :url_to_use => ''
      end
    end
    
    Role.rebuild_cache
  end

  def self.down
    controller_id = SiteController.find_by_name('users').id
    ['contributions', 'contributions_new'].each do |action|
      ControllerAction.find_all_by_site_controller_id_and_name(controller_id, action).each &:destroy
    end
    
    SiteController.find_by_name('assessment360').destroy
    
    Role.rebuild_cache
  end
end
