module FileController
  def self.create_file(name)
    # will create .txt file with given name at the personal data folder
  end

  def self.open_summary
    sum_path = File.expand_path("../../data/personal/sum.txt", __dir__)
    
    if File.exist?(sum_path)
      content = File.readlines(sum_path)
    else
      puts "File not found on #{sum_path}"
    end

    content
  end
end