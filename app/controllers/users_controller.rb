class UsersController < ApplicationController
  
  def my_portfolio
    @user = current_user #Ensures user is logged in.
    @user_stocks = current_user.stocks #Returns all of the user's stocks.
  end
  
  def my_friends
    @friendships = current_user.friends
  end
  
  def search
    #The next two lines were replaced with the code below them in Section 8, Lecture 196.
    #@users = User.search(params[:search_param])#The .search() method must be created(defined) in the users.rb model file.
    #render json: @users
    #This code copied from stock_controller.rb, search method & adjusted.
    if params[:search_param].blank? #Checks if search_param is blank
      flash.now[:danger] = "You have entered an empty search string." #blank error message.
    else
      @users = User.search(params[:search_param] )#Takes in @users instance variable params
      @users = current_user.except_current_user(@users) #current_user calls except_current_user method, which passes in an instance of @users.  Prevents current_user from being included in friends search.
      flash.now[:danger] = "No users match this search criteria." if @users.blank? #Checks that it isn't an unmatched search param.
    end
    #This do block differs from Rails 4 code.
    respond_to do |format|
      format.js {render partial: 'friends/result' } #Render the /users_result partial in all three cases.
    end
  end
  
  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id) #Builds an association between current_user & friend_id.
    if current_user.save
      flash[:notice] = "Friend was successfully added"
    else
      flash[:danger] = "There was something wrong with the friend request"
    end  
    redirect_to my_friends_path
  end
  
  def show
    @user = User.find(params[:id]) #Grabs the user object.
  @user_stocks = @user.stocks
  end
end