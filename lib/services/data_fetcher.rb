require_relative 'file_controller'

module Fetcher 
  def self.fetch_summarry
    raw_summary = FileController.open_summary
    

    last_known = raw_summary.last #sum date - string
    

    sum, date = last_known.split(" ")

    return [sum, date] unless sum == "sum" && date == "date"

    [nil, nil] # if there are no logs in summary
  end
end