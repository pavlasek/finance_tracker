require_relative 'data_fetcher'
require_relative '../utils/utils'

module GraphViewer
  def self.view_sum
    summary_list = Fetcher.fetch_summarry_list

    summary_json = convert_summary_to_json(summary_list)

    puts summary_json
    
    # call the graph function in python and pass the json
    IO.popen(["venv/bin/python", "lib/python/plotter.py"], "w") do |io|
      io.write(summary_json)
    end
  end
end