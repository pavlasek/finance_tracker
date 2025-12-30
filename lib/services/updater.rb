# frozen_string_literal: true

require_relative 'data_fetcher'
require_relative 'file_controller'

# module Updater takes care of updating the data
module Updater
  def self.update_all
    assets = Fetcher.fetch_assets

    if assets.empty?
      puts 'there are no assets to update...'
      return nil
    end

    assets.each do |asset|
      update(asset)
    end
  end

  def self.update(asset_name)
    puts "updating #{asset_name}..."
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
      complete_value = value.to_f + initial_value.to_f
      FileController.update_summary(date, complete_value.to_s)
    else
      complete_value = value.to_f + initial_value.to_f
      FileController.write_summary(date, complete_value.to_s)
    end
  end
end
