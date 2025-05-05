class ApplicationsController < ApplicationController
  def activated
    @applications = Application.eager_load(:job).merge(Job.activated)
  end
end
