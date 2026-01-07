# frozen_string_literal: true

require_relative 'file_controller'

# module Fetcher takes care of fetching data e.g. assets, summary, currency codes...
module Fetcher
  def self.fetch_summarry
    raw_summary = FileController.open_summary

    last_known = raw_summary.last # sum date - string

    sum, date = last_known.split(' ')

    return [sum, date] unless sum == 'sum' && date == 'date'

    [nil, nil] # if there are no logs in summary
  end

  def self.fetch_assets
    raw_assets = FileController.open_assets_summary

    assets = []
    raw_assets.each_with_index do |asset, index|
      next if index.zero?

      asset.strip!
      assets.append(asset)
    end

    assets
  end

  def self.fetch_currency_codes
    # TODO: implement fetching actual data
    %w[CZK EUR]
  end

  # fetches currency code and the last known balance of the asset
  def self.fetch_asset_info(asset)
    lines = FileController.open_asset(asset)

    first_line_array = lines[0].split(' ')
    currency_code = first_line_array[1]

    last_line_array = lines[-1].split(' ')
    balance = last_line_array[1]

    [balance, currency_code]
  end
end
