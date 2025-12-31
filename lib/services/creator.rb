# frozen_string_literal: true

require_relative 'file_controller'
require_relative '../utils/utils'
require_relative 'updater'
require 'date'

# module Creator takes care of creating an asset
module Creator
  def self.add_asset(name, initial_value, currency_code)
    # create a file name
    file_name = name_create(name)
    file_name_with_ext = "#{file_name}.txt"
    puts "#{file_name} was created"

    # create an item file
    FileController.create_file(file_name_with_ext, currency_code)

    # add to assets file
    Updater.update_assets_list(file_name)

    # write the initial log
    date = DateTime.now.strftime('%d-%m-%Y')
    FileController.write_asset_log(file_name, initial_value, date.to_s)

    # update the summary
    initial_value_to_czk = convert_to_czk(currency_code, initial_value)
    Updater.update_summary(initial_value_to_czk, date.to_s)
  end
end
