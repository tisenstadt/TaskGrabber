require './asana.rb'
$asana_personal_token = String.new
$github_personal_token = String.new

class TokenCollector
  attr_reader :asana
  
  def initialize(args)
    @asana = args[:asana]
  end

  def run_program
    puts "Welcome to TaskGrabber, an application to convert Asana tasks to GitHub Issues"
    get_asana_token
    get_github_token
    asana.run_queries
  end

  def get_asana_token
    print "Please enter your Asana personal token for authentication: "
    $asana_personal_token = gets.chomp
  end

  def get_github_token
    print "Please enter your Github personal token for authentication: "
    $github_personal_token = gets.chomp
  end
end

