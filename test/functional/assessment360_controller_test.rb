#require File.dirname(__FILE__) + '/../test_helper'
#require 'admin_controller'
require 'test_helper'


#Functional tests for Assessment360Controller.

class Assessment360ControllerTest < ActionController::TestCase
  fixtures :users, :roles, :system_settings, :content_pages,:participants
  fixtures :permissions, :roles_permissions, :controller_actions
  fixtures :site_controllers, :menu_items, :courses , :tree_folders, :assignments
  set_fixture_class :system_settings => 'SystemSettings' 
  set_fixture_class :roles_permissions => 'RolesPermission'

  def setup
    @controller = Assessment360Controller.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:user] = users(:superadmin)
    Role.rebuild_cache
    AuthController.set_current_role(users(:superadmin).role_id,@request.session)

  end

  test "should get one course all assignments" do

    get(:one_course_all_assignments, {:course_id => courses(:course1).id})
    assert_response :success

  end

  test "should get all_assignments_all_students" do
    get( :all_assignments_all_students,{:course_id => courses(:course1).id})
    assert_response :success

  end
  test "should get one_assignment_all_students" do
    get (:one_assignment_all_students,{:assignment_id => assignments(:assignment1).id})
    assert_response :success

  end
  test "should get one_student_all_reviews" do
    get (:one_student_all_reviews,{:course_id => courses(:course0).id , :student_id => participants(:par5).id})
    assert_response :success

  end


   test "one_assignment_one_student" do
    #@assignment = Assignment.find_by_id(params[:assignment_id])
    #@participant = Participant.find_by_user_id(params[:user_id])
    get (:one_assignment_one_student,{:assignment_id => assignments(:assignment1).id , :user_id => participants(:par1).user_id})
    assert_response :success

  end

  test "all_students_all_reviews" do

    get (:all_students_all_reviews,:course_id => courses(:course0).id)
    assert_response :success
  end

  test "all_students_all_reviews fail" do
    #@assignment = Assignment.find_by_id(params[:assignment_id])
    #@participant = Participant.find_by_user_id(params[:user_id])
    @request.session[:user] = users(:student1)
    Role.rebuild_cache
    AuthController.set_current_role(users(:student1).role_id,@request.session)
    get (:all_students_all_reviews,:course_id => courses(:course0).id)
    assert_redirected_to "denied"
  end

  test "one_assignment_one_student fail" do
    @request.session[:user] = users(:student1)
    Role.rebuild_cache
    AuthController.set_current_role(users(:student1).role_id,@request.session)
    get (:one_assignment_one_student,{:assignment_id => assignments(:assignment1).id , :user_id => participants(:par1).user_id})

    assert_redirected_to "denied"
  end

  test "one_student_all_reviews fail" do
    @request.session[:user] = users(:student1)
    Role.rebuild_cache
    AuthController.set_current_role(users(:student1).role_id,@request.session)
    get (:one_student_all_reviews,{:course_id => courses(:course0).id , :student_id => participants(:par5).id})

    assert_redirected_to "denied"
  end

  test "all_assignments_all_students fail" do
    @request.session[:user] = users(:student1)
    Role.rebuild_cache
    AuthController.set_current_role(users(:student1).role_id,@request.session)
    get( :all_assignments_all_students,{:course_id => courses(:course1).id})

    assert_redirected_to "denied"
  end


  test "one_course_all_assignments fail" do
    @request.session[:user] = users(:student1)
    Role.rebuild_cache
    AuthController.set_current_role(users(:student1).role_id,@request.session)
    get(:one_course_all_assignments, {:course_id => courses(:course1).id})

    assert_redirected_to "denied"
  end

end

