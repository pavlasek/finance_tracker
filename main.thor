require_relative 'lib/services/logger'

class FinanceTracker < Thor 
  desc "help", "runs help for using the product"
  def help
    Logger.log_help
  end

  desc "summary", "shows sumarry of your assests"
  def summary
    Logger.log_summary
  end
end