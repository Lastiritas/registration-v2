class AdminController < ApplicationController
  before_action :admin_user

  def index
  end

  def registrations
    @submissions = Submission.all
  end
end
