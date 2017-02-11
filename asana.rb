require 'net/https'
require 'uri'
require 'JSON'
require './json.rb'
require './task_processor.rb'

class Asana
  attr_accessor :messages, :queries, :workspace_id, :project_id, :tasks, :formatted_tasks
  attr_reader :json, :task_processor, :base_url

	def initialize(args)
    @json = args[:json]
    @task_processor = args[:task_processor]
    @workspace_id = nil
    @project_id = nil
    @tasks = Array.new  
    @formatted_tasks = Array.new
    @queries =  ["workspaces"]
    @messages = {:workspaces => "Here are your Asana workspaces. Please enter the workspace id from which you want to migrate tasks.",
                 :projects => "Here are your Asana projects. Please enter the project id from which you want to migrate tasks.",
                 :tasks => "Here are the tasks that will be migrated to GitHub as Issues."}
    @base_url = "https://app.asana.com/api/1.0/"
	end

  def query_tasks
    count = 0
    queries.each do |query|
      output = get_query_results(query)
      add_query(count)
      count += 1
      extract_task_ids(output) if count == 3
    end
    collect_tasks_for_export
    task_processor.process_tasks(self)
  end

  def add_query(count)
    if count == 0
        puts messages[:workspaces]
        self.workspace_id = gets.chomp
        self.queries[1] = "workspaces/#{workspace_id}/projects"
      elsif count == 1
        puts messages[:projects]
        self.project_id = gets.chomp
        self.queries[2] = "projects/#{project_id}/tasks"
      elsif count == 2
        puts messages[:tasks]
    end
  end
    

  def get_query_results(query, printout = true) 
    response = query_asana(query)
    data_output = send_to_json(response, printout)
  end

  def query_asana(query)
    uri = connect_to_asana(query)
    http = new_http(uri)
    response = process_post(uri, http)
  end

  def connect_to_asana(destination)
    uri = URI.parse(base_url + destination)
  end

  def new_http(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http
  end

  def process_post(uri, http)
    request = Net::HTTP::Get.new(uri)
    request.basic_auth($asana_personal_token, '')
    response = http.request(request)
  end

  def send_to_json(response, printout)
    json.parse_asana(response, printout)
  end

  def extract_task_ids(task_data)
    task_data.each do |task|
      self.tasks << task["id"]
    end
  end

  def collect_tasks_for_export
    tasks.each do |task_id|
      task_data = get_query_results("tasks/#{task_id}", false) 
      formatted_tasks << task_data
    end
  end
end