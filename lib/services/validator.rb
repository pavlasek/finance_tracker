# frozen_string_literal: true

require_relative 'data_fetcher'

# module Validator takes care of validations
# for now it is doing the validations of user input when creating a new asset
module Validator
  def self.validate_name(name)
    # regex checking if the name consist only from letters a-z to A-Z
    name.match?(/\A[a-zA-Z ]+\z/)
  end

  def self.validate_initial_value(initial_value)
    initial_value.match(/\A\d+(\.\d+)?\z/)
  end

  def self.validate_currency_code(currency_code)
    valid_currency_codes = Fetcher.fetch_currency_codes

    valid_currency_codes.include?(currency_code.upcase) || false
  end
end
