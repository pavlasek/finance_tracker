require_relative 'data_fetcher'

module Logger
  def self.log_help
    puts "----------------------------------------------------------------------"

    puts "COMMMANDS TO USE:"
    puts " - help - will show the help"

    puts "----------------------------------------------------------------------"
  end

  def self.log_summary
    puts "----------------------------------------------------------------------"
    summary, date = Fetcher.fetch_summarry

    if summary && date 
      puts " - networth: #{summary} CZK"
      puts " - date: #{date}"  
    else
      puts " - no known records to make a summary..."
    end
    
    puts "----------------------------------------------------------------------"
  end
end