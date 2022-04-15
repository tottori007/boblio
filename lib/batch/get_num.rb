# bundle exec rails runner Batch::GetNum.getNum [username]
# IN  [username]
# OUT file: tmp/bgglist/numYYYYMMDDHHMM.csv

USER_NAME = "Tottory"
BGG_URL_BASE = "https://api.geekdo.com/xmlapi2/collection?"
OUT_FILE_PATH = "tmp/bgglist/"
OUT_FINE_NAME = "num" # numYYYYMMDDHHMM.csv

class Batch::GetNum
  require 'rexml/document'

  def self.getNum
    puts '--- Batch::GetNum.getNum START ---'

    ARGV[0] ? user = ARGV[0] : user = ::USER_NAME

    palams = URI.encode_www_form(username: user)
    uri = URI.parse(::BGG_URL_BASE + palams)
    response = Net::HTTP.get_response(uri)
    doc = REXML::Document.new(response.body)

    puts '--- Request '+uri.to_s+' ---'

    number = []
    doc.elements.each('items/item') do |element|
      number.push(element.attributes["objectid"])
    end

    time_stamp = DateTime.now.strftime('%Y%m%d%H%M')
    file_name = ::OUT_FILE_PATH + ::OUT_FINE_NAME + time_stamp

    File.open(file_name, "w") do |num|
      number.uniq.each { |n| num.puts(n) }
    end

    puts '--- Write count : ' + number.size.to_s + ' ---'
    puts '--- Create ' + file_name + ' ---'

    puts '--- Batch::GetNum.getNum END ---'
  end

end