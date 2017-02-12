require 'net/https'
require 'uri'
require 'JSON'
require './json.rb'
require './task_processor.rb'

class Asana
  attr_accessor :tasks, :formatted_tasks, :workspace_ids, :project_ids
  attr_reader :json, :task_processor, :base_url

  def initialize(args)
    @json = args[:json]
    @task_processor = args[:task_processor]
    @tasks = Array.new  
    @formatted_tasks = Array.new
    @workspace_ids = Array.new
    @project_ids = Array.new
    @base_url = "https://app.asana.com/api/1.0/"
  end

  def query_workspaces
    output = get_query_results("workspaces") #Query returns workspaces. Program exits if authentication is invalid.
    if output.nil?
      puts "Authentication Error - Please Verify Asana Access Token"
      exit(1)
    end
    output.each do |workspace|
      workspace_ids << workspace["id"]
    end
  end

  def query_projects
    workspace_ids.each do |workspace| 
      output = get_query_results("workspaces/#{workspace}/projects") #Query returns projects associated with workspace.
      output.each do |project|
        project_ids << project["id"]
      end
    end
  end

  def query_tasks
    project_ids.each do |project| #Query returns tasks associated with projects.
      output = get_query_results("projects/#{project}/tasks")
      output.each do |task|
         tasks << task["id"]
      end
    end
  end

  def collect_tasks_for_export
    tasks.each do |task_id|
      task_data = get_query_results("tasks/#{task_id}") 
      formatted_tasks << task_data
    end
  end

  def run_queries 
    query_workspaces
    query_projects
    query_tasks
    collect_tasks_for_export
    task_processor.process_tasks(self)
  end

  def get_query_results(query) #Returning the query results requires establishing a connection to the Asana API. This is done through the following methods. 
    response = query_asana(query)
    data_output = send_to_json(response)
  end

  def query_asana(query)
    uri = connect_to_asana(query) 
    http = new_http(uri)
    response = process_get(uri, http)
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

  def process_get(uri, http)
    request = Net::HTTP::Get.new(uri)
    request.basic_auth($asana_personal_token, '')
    response = http.request(request)
  end

  def send_to_json(response)
    json.parse_asana(response)
  end
end
