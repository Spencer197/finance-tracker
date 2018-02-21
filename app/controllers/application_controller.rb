class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception#This line must come before the before_action line.
  before_action :authenticate_user!#Ensures that a user is logged in before actions can be taken in the app.
end
