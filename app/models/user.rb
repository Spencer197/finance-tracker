class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  
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
end
