class HomeController < ApplicationController
  def index
    @recordings = Recording.order(date: :asc, time_start: :asc)
  end
end
