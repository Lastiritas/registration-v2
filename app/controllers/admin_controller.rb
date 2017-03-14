class AdminController < ApplicationController

  def index
  end

  def registrations
    @submissions = Submission.all
  end
end
