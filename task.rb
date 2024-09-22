# frozen_string_literal: true

# The Task class is used to represent a task in the Task Tracker CLI.
class Task
  attr_accessor :id, :description, :status, :created_at, :updated_at

  def initialize(id, description, status = 'todo')
    @id = id
    @description = description
    @status = status
    @created_at = Time.now
    @updated_at = Time.now
  end

  # NOTE: Codes below are needed when dealing with each task as object.

  # def update_description(new_description)
  #   @description = new_descaription
  #   @updated_at = Time.now
  # end

  # def mark_in_progress
  #   @status = 'in_progress'
  #   @updated_at = Time.now
  # end

  # def mark_done
  #   @status = 'done'
  #   @updated_at = Time.now
  # end
end
