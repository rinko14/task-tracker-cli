# frozen_string_literal: true

require 'json'

def load_tasks
  if File.exist?('tasks.json')
    file = File.read('tasks.json')
    JSON.parse(file)
  else
    []
  end
end

def save_tasks(tasks)
  File.write('tasks.json', JSON.pretty_generate(tasks))
end
