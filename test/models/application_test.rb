require "test_helper"

class ApplicationTest < ActiveSupport::TestCase
  setup do
    @job = Job.create! title: 'Some Job'
    @app1 = @job.applications.create! candidate_name: 'John Doe'
  end
 
  test "basic event sourcing" do
    assert_equal @app1.status, 'applied', 'fresh app status is `applied`'

    assert_attributes @job, {hired_cnt: 0, ongoing_cnt: 1, rejected_cnt: 0},
      "application counts are properly recalculated"

    @app1.events.create! type: Application::Event::Note, content: 'note 1'
    @app1.reload
    @job.reload
    assert_equal @app1.status, 'applied', 'note events do not change status'
    assert_equal @app1.notes_cnt, 1, 'notes are properly counted'

    int_at = 2.days.from_now.beginning_of_day
    @app1.events.create! type: Application::Event::Interview,
      interview_at: int_at
    @app1.reload
    @job.reload
    assert_equal @app1.status, 'interview', 'interview event sets status'
    assert_equal @app1.last_interview_at, int_at,
      'interview event sets last_interview_at'
    assert_attributes @job, {hired_cnt: 0, ongoing_cnt: 1, rejected_cnt: 0},
      "application counts are properly recalculated"

    @app1.events.create! type: Application::Event::Note, content: 'note 2'
    reject = @app1.events.create! type: Application::Event::Rejected
    @app1.reload
    @job.reload
    assert_equal @app1.status, 'rejected', 'most recent event sets status'
    assert_attributes @job, {hired_cnt: 0, ongoing_cnt: 0, rejected_cnt: 1},
      "application counts are properly recalculated"

    reject.destroy
    @app1.reload
    @job.reload
    assert_equal @app1.status, 'interview', 'event destruction is handled'
    assert_attributes @job, {hired_cnt: 0, ongoing_cnt: 1, rejected_cnt: 0},
      "application counts are properly recalculated"
  end

  protected

  def assert_attributes(object, attributes, message = nil)
    attributes.each {|k, v| assert_equal object.send(k), v, message }
  end
end
