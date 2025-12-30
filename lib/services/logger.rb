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
    puts '----------------------------------------------------------------------'
  end

  def self.log_summary
    puts '----------------------------------------------------------------------'
    summary, date = Fetcher.fetch_summarry

    if summary && date
      puts " - networth: #{summary} CZK"
      puts " - date: #{date}"
    else
      puts ' - no known records to make a summary...'
    end

    puts '----------------------------------------------------------------------'
  end
end
