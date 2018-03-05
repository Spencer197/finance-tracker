class UsersController < ApplicationController
  
  def my_portfolio
    @user = current_user#Ensures user is logged in.
    @user_stocks = current_user.stocks#Returns all of the user's stocks.
  end
  
  def my_friends
    
  end
end