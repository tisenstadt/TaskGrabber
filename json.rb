class JSONParser
	def initialize
  end

  def parse_asana(url_response, print_contents = true)
    body = JSON.parse(url_response.body)
    print_contents(body) unless !print_contents
    body["data"]
  end

  def print_contents(body)
    contents = body["data"]
    p contents
    contents.each do |data|
      data.each do |key, value|
        print "#{key}: #{value} "
      end
      puts "\n"
    end
  end
end