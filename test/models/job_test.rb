require "test_helper"

class JobTest < ActiveSupport::TestCase
  setup do
    @job = Job.create! title: 'Some Job'
  end
  test "basic event sourcing" do
    assert_equal @job.status, 'deactivated', 'fresh job is deactivated'

    @job.events.create! type: Job::Event::Activated
    assert_equal @job.status, 'activated', 'job events set status'

    e1 = @job.events.create! type: Job::Event::Deactivated
    @job.reload
    assert_equal @job.status, 'deactivated', 'most recent job event wins'

    e1.destroy
    @job.reload
    assert_equal @job.status, 'activated', 'event destruction is handled'

    @job.events.destroy_all
    @job.reload

    assert_equal @job.status, 'deactivated', 'mass event destruction is handled'
  end
end
