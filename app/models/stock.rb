class Stock < ApplicationRecord

  def self.new_from_lookup(ticker_symbol)
  begin
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    price = strip_commas(looked_up_stock.l)
    new(name: looked_up_stock.name, ticker: looked_up_stock.symbol, last_price: price)
  rescue Exception => e#Rails code for catching an exception such as blank or incorrect ticker symbol.
    return nil#If an exception is caught it returns nil.
  end
end
  
  def self.strip_commas(number)
    number.gsub(",", "")#Here the gsub method strips out the comma from the stock price(number) and replaces it with nothing.   
  end
  
end