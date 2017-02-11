require './github.rb'

class TaskProcessor
	attr_reader :github
  def initialize(args)
    @github = args[:github]
  end

  def process_tasks(asana)
    tasks = asana.formatted_tasks
    tasks.each do |task|
      reformat_task_keys(task)
      reformat_task_state_value(task)
    end  
    github.upload_tasks(tasks)
  end

  def reformat_task_keys(task)
    task["title"] = task.delete("name")
    task["body"] = task.delete("notes")
    task["state"] = task.delete("completed")
  end

  def reformat_task_state_value(task)
    task["state"] = "closed" if task["state"]
    task["state"] = "open" if !task["state"] 
  end
end