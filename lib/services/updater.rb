# frozen_string_literal: true

require_relative 'data_fetcher'
require_relative 'file_controller'
require 'date'
require_relative '../utils/utils'

# module Updater takes care of updating the data
module Updater
  def self.update_asset(asset_name, new_value)
    puts "updating #{asset_name}..."
    raw_asset = FileController.open_asset(asset_name)
    _, currency = raw_asset[0].split

    date, old_value = raw_asset[-1].split
    today = DateTime.now.strftime('%d-%m-%Y')
    if date == today
      FileController.rewrite_asset_log(asset_name, new_value, today)
    else
      FileController.write_asset_log(asset_name, new_value, today)
    end

    #update summary
    difference = (new_value.to_f - old_value.to_f).round(2)

    diff_in_czk = convert_to_czk(currency, difference)

    self.update_summary(diff_in_czk, today)
  end

  def self.update_assets_list(new_asset)
    assets = Fetcher.fetch_assets

    assets.append(new_asset)

    FileController.write_assets_list(assets)
  end

  def self.update_summary(initial_value, date)
    summary_date, value = Fetcher.fetch_summarry
    if summary_date.nil?
      FileController.write_summary(date, initial_value.to_s)
    elsif summary_date == date
      complete_value = (value.to_f + initial_value.to_f).round(2)
      FileController.update_summary(date, complete_value.to_s)
    else
      complete_value = (value.to_f + initial_value.to_f).round(2)
      FileController.write_summary(date, complete_value.to_s)
    end
  end
end
