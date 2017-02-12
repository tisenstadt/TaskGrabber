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
      reformat_task_values(task)
    end  
    github.upload_tasks(tasks)
  end

  def reformat_task_keys(task)
    task["title"] = task.delete("name")
    task["body"] = task.delete("notes")
    task["state"] = task.delete("completed")
    task["labels"] = task.delete("tags") #Adding label to help distinguish imported tasks from regular tasks. Marked as "Asana".
  end

  def reformat_task_values(task)
    task["state"] = "closed" if task["state"]
    task["state"] = "open" if !task["state"] 
    task["labels"] << "Asana"
  end
end