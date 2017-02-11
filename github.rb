class GitHub
  attr_accessor :base_url, :post_url, :patch_url, :patch_info, :post_uri, :post_http
	def initialize
    @base_url = "https://api.github.com/repos/"
    @post_url = String.new
    @patch_url = String.new
    @patch_info = {"state" => "closed"}
    @post_uri = nil
    @post_http = nil
  end

  def upload_tasks(tasks)
    set_destination_repository
    tasks.each do |task|
      response = process_post(self.post_uri, self.post_http, {"body" => task["body"], "title" => task["title"]})
      check_for_closed_state(task, response)
    end
    puts "Task upload to GitHub Issues has completed."
  end

  def set_destination_repository
    puts "Please enter the username of the repository to receive the issues."
    username = gets.chomp
    puts "Now enter the name of the repository to receive the issues."
    repository = gets.chomp
    self.post_url = base_url + username + "/" + repository + "/" + "issues"
    set_github_post_connection #Setting the connection here to prevent unnecessary repeated calls to an identical post URL.
  end

  def set_github_post_connection
    self.post_uri = URI.parse(post_url)
    self.post_http = new_http(post_uri) 
  end

  def process_post(uri , http , task_body)
    send_post_request(uri, http, task_body)
  end

  def new_http(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http
  end

  def send_post_request(uri, http, task_body)
    request = Net::HTTP::Post.new(uri)
    request.body = task_body.to_json
    request.basic_auth($github_personal_token, '')
    response = http.request(request)
  end

  def check_for_closed_state(task, response)
    if task["state"] == "closed"
        post_id = get_post_id(response)
        self.patch_url = post_url + "/" + post_id
        process_patch(patch_info)
    end
  end

  def get_post_id(response)
    json = JSON.parse(response.body)
    json["number"].to_s
  end  

  def process_patch(task_body)
    uri = URI.parse(patch_url)
    http = new_http(uri)
    send_patch_request(uri, http, task_body)
  end

  def send_patch_request(uri, http, task_body)
    request = Net::HTTP::Patch.new(uri)
    request.body = task_body.to_json
    request.basic_auth($github_personal_token, '')
    http.request(request)
  end
end

