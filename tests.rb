require 'test/unit'
require './task_processor.rb'
require './github.rb'

class TaskProcessorTest < Test::Unit::TestCase
  def setup
    @task = TaskProcessor.new(:github => nil)
    @task_hash = {"name" => "Morning",
                  "notes" => "Make breakfast.",
                  "completed" => true,
                  "tags" => [] } 
    @task_hash_correct_keys = {"title" => "Morning",
                               "body" => "Make breakfast.",
                               "state" => true,
                               "labels" => []
                               }
    @task_hash_correct_keys_incomplete = {"title" => "Morning",
                                          "body" => "Make breakfast.",
                                          "state" => false,
                                          "labels" => []
                                          }
  end

  def test_to_switch_keys
    completed_hash = {"title" => "Morning",
                      "body" => "Make breakfast.",
                      "state" => true,
                      "labels" => []}
    @task.reformat_task_keys(@task_hash)
    assert_equal completed_hash, @task_hash
  end

  def test_to_switch_state_value_on_complete
    completed_hash = {"title" => "Morning",
                      "body" => "Make breakfast.",
                      "state" => "closed",
                      "labels" => ["Asana"]}
    @task.reformat_task_values(@task_hash_correct_keys)
    assert_equal completed_hash, @task_hash_correct_keys
  end

  def test_to_switch_state_value_on_incomplete
    completed_hash = {"title" => "Morning",
                      "body" => "Make breakfast.",
                      "state" => "open",
                      "labels" => ["Asana"]}
    @task.reformat_task_values(@task_hash_correct_keys_incomplete)
    assert_equal completed_hash, @task_hash_correct_keys_incomplete
  end
end