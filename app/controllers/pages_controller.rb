class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]
  def home
  end

  def show

  end

  def index
    if params[:query].present?
      sql_query = "user_name ILIKE :query OR github_nickname ILIKE :query"
      @users = User.where(sql_query, query: "%#{params[:query]}%")
    else
      @users = User.all
    end
  end
end
