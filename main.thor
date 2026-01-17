# frozen_string_literal: true

require_relative 'lib/services/logger'
require_relative 'lib/services/updater'
require_relative 'lib/services/creator'
require_relative 'lib/services/validator'
require_relative 'lib/services/data_fetcher'
require_relative 'lib/services/graph_viewer'

class Tracker < Thor
  desc 'help', 'runs help for using the product'
  def help
    Logger.log_help
  end

  desc 'summary', 'shows sumarry of your assests'
  def summary
    Logger.log_summary
  end

  desc 'update_all', 'updates all the data'
  def update_all
    assets = Fetcher.fetch_assets
    if assets.empty?
      puts 'there are no assets to update...'
      return nil
    end

    assets.each do |asset|
      valid_value = false
      while valid_value == false
        new_value = ask("input current value of #{asset}:")
        if Validator.validate_initial_value(new_value)
          valid_value = true
        else
          puts "value is invalid, use only numbers 1-9 and decimal point '.'"
        end
      end
      
      Updater.update_asset(asset, new_value)
    end
  end

  desc 'add_asset', 'adds asset into the database of assets'
  def add_asset
    valid_name = false
    while valid_name == false
      name = ask('input the asset name:')
      if Validator.validate_name(name)
        puts 'name is valid'
        valid_name = true
      else
        puts 'name is invalid, use only chars a-z, A-Z and SPACE'
      end
    end

    valid_initial = false
    while valid_initial == false
      initial_value = ask('input the initial value of the asset:')
      if Validator.validate_initial_value(initial_value)
        puts 'initial value is valid'
        valid_initial = true
      else
        puts "initial value is invalid, use only numbers 1-9 and decimal point '.'"
      end
    end

    valid_currency = false
    while valid_currency == false
      currency_code = ask('input the currency code of the assets currency:')
      if Validator.validate_currency_code(currency_code)
        puts 'currency code is valid'
        valid_currency = true
      else
        puts 'currency code is invalid or not supported'
      end
    end

    puts 'creating the asset...'
    Creator.add_asset(name, initial_value, currency_code)
    puts 'asset created :)'
  end

  desc 'list', 'list all the assets that are active and there current value'
  def list
    Logger.log_assets
  end

  desc 'graph_sum', 'shows graph of the summary in time'
  def graph_sum
    GraphViewer.view_sum
  end

  desc 'update', 'update the given asset'
  def update
    assets = Fetcher.fetch_assets

    valid_name = false
    while valid_name == false
      asset = ask('input the asset name:')
      if assets.include?(asset)
        puts 'asset exists'
        valid_name = true
      else
        puts 'asset does not exist'
      end
    end

    valid_value = false
      while valid_value == false
        new_value = ask("input current value of #{asset}:")
        if Validator.validate_initial_value(new_value)
          valid_value = true
        else
          puts "value is invalid, use only numbers 1-9 and decimal point '.'"
        end
      end
      
      Updater.update_asset(asset, new_value)
      puts "#{asset} was updated :)"
  end
end
