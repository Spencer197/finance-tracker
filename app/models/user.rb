class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  
  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"#If no first or last name is given, return "Anonymous".
  end
  
  def stock_already_added?(ticker_symbol)
    stock = Stock.find_by_ticker(ticker_symbol)
    return false unless stock
    user_stocks.where(stock_id: stock.id).exists?#Ensures that the user's id & the stock id are both in the database.
  end
  
  def under_stock_limit?#Sets a limit of ten stocks in one's portfolio.  
    (user_stocks.count < 10)
  end
  
  def can_add_stock?(ticker_symbol)#Ensures that the allowable stock count has not been exceeded & that the stock doesn't already exist.
    under_stock_limit? && !stock_already_added?(ticker_symbol)
  end
  
  #This method prevents the current user from appearing in the friends search results.  Since it is not a class level method, it doesn't need the 'self' keyword.  It will run from an instance of the User class.
  def except_current_user(users)#Passes in an instance or Users class.
    users.reject { |user| user.id == self.id }#Rejects user.id if it matches the cureent user's own(self) id.
  end
  
  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1
  end
  
  def self.search(param)
    param.strip!#Strips begining & ending spaces from search tern/name.
    param.downcase!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq# .uniq removes duplicates
    return nil unless to_send_back#Returns nil if no matches found.
    to_send_back
  end
  
  def self.first_name_matches(param)
    matches('first_name', param)
  end
  
  def self.last_name_matches(param)
    matches('last_name', param)
  end
  
  def self.email_matches(param)
    matches('email', param)
  end
  
  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")#Takes field name entry & finds something similar (like?) to the entry (param).
  end

end
