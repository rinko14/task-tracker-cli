require './task'
require './handle_json'

def handle_command
  command = ARGV[0]

  case command
  when 'add'
    task_description = ARGV[1]
    tasks = load_tasks
    new_task_id = [tasks.length + 1, tasks.map { |task| task['id'] }.max + 1].max # NOTE: To avoid duplicate IDs
    new_task = Task.new(new_task_id, task_description)
    tasks << {
      id: new_task.id,
      description: new_task.description,
      status: new_task.status,
      created_at: new_task.created_at,
      updated_at: new_task.updated_at
    }
    save_tasks(tasks)
    puts "Task added successfully!: #{new_task.description}"
  when 'list'
    tasks = load_tasks
    expected_status = ARGV[1]

    unless expected_status.nil?
      case expected_status
      when 'done'
        tasks = tasks.select { |task| task['status'] == 'done' }
      when 'in-progress'
        tasks = tasks.select { |task| task['status'] == 'in-progress' }
      when 'todo'
        tasks = tasks.select { |task| task['status'] == 'todo' }
      else
        puts 'Invalid status. Please use done, in-progress or todo.'
        return
      end
    end

    tasks.each do |task|
      p "#{task['id']} | #{task['description']} | status: #{task['status']} | created_at: #{task['created_at']} | \
      updated_at: #{task['updated_at']}"
    end
  when 'update'
    task_id = ARGV[1].to_i
    new_description = ARGV[2]

    tasks = load_tasks
    target_task = tasks.find { |task| task['id'] == task_id }
    if target_task.nil?
      puts 'Task not found.'
    else
      target_task['description'] = new_description
      target_task['updated_at'] = Time.now
      save_tasks(tasks)
      puts "Task updated successfully!: #{target_task['description']}"
    end
  when 'delete'
    task_id = ARGV[1].to_i

    tasks = load_tasks
    target_task = tasks.find { |task| task['id'] == task_id }
    if target_task.nil?
      puts 'Task not found.'
    else
      tasks.delete(target_task)
      save_tasks(tasks)
      puts "Task deleted successfully!: #{target_task['description']}"
    end
  when 'mark-done'
    task_id = ARGV[1].to_i

    tasks = load_tasks
    target_task = tasks.find { |task| task['id'] == task_id }
    if target_task.nil?
      puts 'Task not found.'
    else
      target_task['status'] = 'done'
      target_task['updated_at'] = Time.now
      save_tasks(tasks)
      puts "Task marked as done successfully!: #{target_task['description']}"
    end
  when 'mark-in-progress'
    task_id = ARGV[1].to_i

    tasks = load_tasks
    target_task = tasks.find { |task| task['id'] == task_id }
    if target_task.nil?
      puts 'Task not found.'
    else
      target_task['status'] = 'in-progress'
      target_task['updated_at'] = Time.now
      save_tasks(tasks)
      puts "Task marked as in-progress successfully!: #{target_task['description']}"
    end
  else
    puts 'Invalid command. Please use add or list.'
  end
end
