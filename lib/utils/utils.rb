# frozen_string_literal: true

def name_create(name)
  name = name.downcase

  name.gsub(' ', '_')
end

def convert_to_czk(currency_code, value)
  hash_of_rates = {
    'eur' => 24.43,
    'czk' => 1
  }

  value.to_f * hash_of_rates[currency_code]
end
