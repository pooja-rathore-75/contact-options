require 'json'

file_path = 'contact_options.json'
json_data = File.read(file_path)

contacts = JSON.parse(json_data)
puts contacts
