# frozen_string_literal: true

require 'json'

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

# convert_summary_to_json gets array in format [[date1, sum1], [date2, sum2], ...]
# and return json in form of [{date: date1, sum: sum1}, {date: date2, sum: sum2}]
# 
# json objects are then passed to python function to draw graphs of the summary
def convert_summary_to_json(raw_summary)
  sum_hashes = []

  raw_summary.each_with_index do |data, index|

    if index.zero?
      next
    end

    sumarry_hash = {"date" => data[0], "sum" => data[1].to_f}
    sum_hashes.append(sumarry_hash)
  end

  json_summary = JSON.generate(sum_hashes)

  return json_summary
end