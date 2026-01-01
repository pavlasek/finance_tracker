# frozen_string_literal: true

# module FileController takes care of everything connected with file handling
# it is the only place wher the app works with files
module FileController
  def self.create_file(name, currency_code)
    # will create .txt file with given name at the personal data folder
    file_path = File.expand_path("../../data/personal/individual_assets/#{name}", __dir__)

    File.new(file_path, 'w')

    File.open(file_path, 'w+') do |file|
      file.puts "currency: #{currency_code}"
    end
  end

  def self.open_summary
    sum_path = File.expand_path('../../data/personal/sum.txt', __dir__)

    if File.exist?(sum_path)
      content = File.readlines(sum_path)
    else
      puts "File not found on #{sum_path}"
    end

    content
  end

  def self.open_assets_summary
    assets_path = File.expand_path('../../data/personal/assets.txt', __dir__)

    if File.exist?(assets_path)
      content = File.readlines(assets_path)
    else
      puts "File not found on #{assets_path}"
    end

    content
  end

  def self.write_assets_list(assets)
    assets_path = File.expand_path('../../data/personal/assets.txt', __dir__)
    File.open(assets_path, 'w+') do |file|
      file.puts 'name_of_the_asset'
      assets.each do |asset|
        file.puts asset
      end
    end
  end

  def self.write_asset_log(asset_name, value, date)
    asset_path = File.expand_path("../../data/personal/individual_assets/#{asset_name}.txt", __dir__)
    File.open(asset_path, 'a+') do |file|
      file.puts("#{date} #{value}")
    end
  end

  def self.write_summary(date, value)
    sum_path = File.expand_path('../../data/personal/sum.txt', __dir__)

    File.open(sum_path, 'a+') do |file|
      file.puts("#{date} #{value}")
    end
  end

  def self.update_summary(date, value)
    sum_path = File.expand_path('../../data/personal/sum.txt', __dir__)

    lines = File.readlines(sum_path, chomp: true)
    lines[-1] = "#{date} #{value}"

    File.write(sum_path, "#{lines.join("\n")}\n")
  end

  def self.open_asset(asset)
    asset_path = File.expand_path("../../data/personal/individual_assets/#{asset}.txt", __dir__)

    File.readlines(asset_path, chomp: true)
  end
end
