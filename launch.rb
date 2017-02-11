require './token_collector.rb'

collector = TokenCollector.new({:asana => Asana.new({:json => JSONParser.new, :task_processor => TaskProcessor.new({:github => GitHub.new})})})
collector.run_program
