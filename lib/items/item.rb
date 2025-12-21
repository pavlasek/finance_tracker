# class Item represents individual wealth sector e.g. personal account, collection of cars, stocks and etc.
require 'date'

class Item

  def initialize(name, initial_amount, currency_code)
    @name = name
    @currency_code = currency_code
    @initial_amount = initial_amount
    @start_date = DateTime.now

    create_file(name)
  end
end