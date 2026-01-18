# frozen_string_literal: true

require_relative 'data_fetcher'

# module Logger takes care of logging the information to the user
# in the final version it will be the only place where interaction with command line will be
module Logger
  def self.log_help
    puts '----------------------------------------------------------------------'
    puts 'COMMMANDS TO USE:'
    puts ' - help - will show the help'
    puts ' - summary - shows a summary of all the assets'
    puts ' - update_all - update values of all the assets'
    puts ' - add_asset - add the assets into the database'
    puts ' - list - shows the list of all the assets with their current balance'
    puts ' - graph_sum - shows the graph of the summary of the networth'
    puts ' - update - updates only the given asset'
    puts '----------------------------------------------------------------------'
  end

  def self.log_summary
    puts '----------------------------------------------------------------------'
    date, summary = Fetcher.fetch_summarry

    if summary && date
      puts " - networth: #{summary} CZK"
      puts " - date: #{date}"
    else
      puts ' - no known records to make a summary...'
    end

    puts '----------------------------------------------------------------------'
  end

  def self.log_assets
    puts '----------------------------------------------------------------------'
    assets = Fetcher.fetch_assets

    assets.each do |asset|
      balance, currency_code = Fetcher.fetch_asset_info(asset)
      
      balance = format("%.2f", balance.to_f)

      length_of_asset = asset.length
      offset = 5 - Math.log10(balance.to_f).floor
      dots = 20 - length_of_asset + offset
      print "#{asset}:"
      print "." * (dots) 
      print "#{balance} #{currency_code}\n"
    end
    puts '----------------------------------------------------------------------'
  end
end
