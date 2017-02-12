class JSONParser
	def initialize
  end

  def parse_asana(url_response)
    body = JSON.parse(url_response.body)
    body["data"]
  end
end