require File.dirname(__FILE__) + '/../test_helper'

class Assessment360DegreeTest < ActiveSupport::TestCase
  fixtures :assignments, :users

  def setup
    @assessment_controller = Assessment360Controller.new
  end

  def test_average

      #j = 1.to_i
      average = 0;
      meta_scores = ResponseMap.get_assessments_for(users(:student2))

      puts "meta scores : #{meta_scores}"
      if !meta_scores.nil?
        average = @assessment_controller.calculate_average_score(meta_scores)
        assert_equal( 0, average)
      end
   end

end
