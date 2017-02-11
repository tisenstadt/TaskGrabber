require 'test/unit'
require './task_processor.rb'
require './github.rb'

class TaskProcessorTest < Test::Unit::TestCase
  def setup
    @task = TaskProcessor.new(:github => nil)
    @task_hash = {"name" => "Snow White",
                  "notes" => "Snow White goes to market.",
                  "completed" => true } 
    @task_hash_correct_keys = {"title" => "Cinderella",
                               "body" => "Cinderella does chores.",
                               "state" => true}
    @task_hash_correct_keys_incomplete = {"title" => "Jasmine",
                                          "body" => "Jasmine gets on magic carpet.",
                                          "state" => false}
  end

  def test_to_switch_keys
    completed_hash = {"title" => "Snow White",
                      "body" => "Snow White goes to market.",
                      "state" => true}
    @task.reformat_task_keys(@task_hash)
    assert_equal completed_hash, @task_hash
  end

  def test_to_switch_state_value_on_complete
    completed_hash = {"title" => "Cinderella",
                      "body" => "Cinderella does chores.",
                      "state" => "closed"}
    @task.reformat_task_state_value(@task_hash_correct_keys)
    assert_equal completed_hash, @task_hash_correct_keys
  end

  def test_to_switch_state_value_on_incomplete
    completed_hash = {"title" => "Jasmine",
                      "body" => "Jasmine gets on magic carpet.",
                      "state" => "open"}
    @task.reformat_task_state_value(@task_hash_correct_keys_incomplete)
    assert_equal completed_hash, @task_hash_correct_keys_incomplete
  end
end