class UsersController < ApplicationController
  def show
    @user = current_user
    @favourites = @user.favourites
  end
end
