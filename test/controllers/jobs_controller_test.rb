require "test_helper"

class JobsControllerTest < ActionDispatch::IntegrationTest
  JOB_KEYS = Set.new [
    "title", "status", "hired_cnt", "rejected_cnt", "ongoing_cnt"
  ]
  test "should get index with proper set of fields" do
    get jobs_url
    assert_response :success
    rkeys = Set.new JSON.parse(@response.body).first.keys
    assert_operator rkeys, :>=, JOB_KEYS
  end
end
