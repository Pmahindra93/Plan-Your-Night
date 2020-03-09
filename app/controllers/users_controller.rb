class UsersController < ApplicationController
  def show
    @user = current_user
    @favourites = @user.favourites
    @nightouts = @user.nights.select { |night| night.venues.length >= 1 }
  end
end
