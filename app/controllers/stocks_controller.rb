class StocksController < ApplicationController
=begin - This commented out code is replaced by that below to extract redundancies.
  def search
    if params[:stock].present?
      @stock = Stock.new_from_lookup(params[:stock])
      if @stock#Means if input not nil (not blank)
        respond_to do |format|#respond_to is a rails method that takes a block, which by convention is called 'format'.
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now[:danger] = "You have entered an incorrect symbol"# .now added after ajax to limit errors message to one redirect cycle. 
          #redirect_to my_portfolio_path - used before ajax was added.
          format.js {render partial: 'users/result'}
        end
      end
    else
      respond_to do |format|
        flash[:danger] = "You have entered an empty search string"
        #redirect_to my_portfolio_path - used before ajax was added.
        format.js {render partial: 'users/result'}
      end
    end
  end
=end
  def search
    if params[:stock].blank?#Check if stock symbol is blank
      flash.now[:danger] = "You have entered an empty search string"#blank error message.
    else
      @stock = Stock.new_from_lookup(params[:stock])#Take @stock instance variable params
      flash.now[:danger] = "You have entered an incorrect symbol" unless @stock#Check that it isn't a incorrect symbol
    end
    respond_to do |format|
      format.js { render partial: 'users/result' }#Render the _result partial in all three cases.
    end
  end
end