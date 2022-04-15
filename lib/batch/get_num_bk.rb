# bundle exec rails runner Batch::GetNum.getNum [pageNo]
# IN  [pageNo]
# OUT file: tmp/bgglist/numYYYYMMDDHHMMpage[pageNo].csv

class Batch::GetNum
  require 'rexml/document'

  def self.getNum
    puts '--- Batch::GetNum.getNum START ---'

    user = "sa266"
    ARGV[0] ? page = ARGV[0] : page = 1

    palams = URI.encode_www_form(username: user, page: page.to_s)
    uri = URI.parse("https://api.geekdo.com/xmlapi2/plays?" + palams)
    response = Net::HTTP.get_response(uri)
    doc = REXML::Document.new(response.body)

    number = []
    doc.elements.each('plays/play/item') do |element|
      number.push(element.attributes["objectid"])
    end

    time_stamp = DateTime.now.strftime('%Y%m%d%H%M')
    file_name = "tmp/bgglist/num" + time_stamp + "page" + page.to_s

    File.open(file_name, "w") do |num|
      number.uniq.each { |n| num.puts(n) }
    end

    puts '--- Create ' + file_name + ' ---'

    puts '--- Batch::GetNum.getNum END ---'
  end

end