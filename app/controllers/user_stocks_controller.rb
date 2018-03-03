class UserStocksController < ApplicationController
  
  def create
     stock = Stock.find_by_ticker(params[:stock_ticker])
    if stock.blank?#Meaning if the stock is not in the stocks table...
      stock = Stock.new_from_lookup(params[:stock_ticker])#look up the stock.
      stock.save#Then save the stock in the stocks table.
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)#Creates the use_stock instance variable.
    flash[:success] = "The stock #{@user_stock.stock.name} was successfully added to your portfolio."
    redirect_to my_portfolio_path
  end
end
