require "test_helper"

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  APP_KEYS = Set.new [
    "candidate_name", "status", "notes_cnt", "last_interview_at", "job_title"
  ]
  test "should get activated with proper set of fields" do
    get applications_activated_url
    assert_response :success
    rkeys = Set.new JSON.parse(@response.body).first.keys
    assert_operator rkeys, :>=, APP_KEYS
  end
end
