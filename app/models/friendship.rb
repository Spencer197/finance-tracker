class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => 'User'#States that friend belongs to the User class.
end
