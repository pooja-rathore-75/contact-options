require 'json'

file_path = 'contact_options.json'
json_data = File.read(file_path)

contacts = JSON.parse(json_data)

contacts.each do |contact|
  ranking = 3
  ranking += 2 unless ['gmail.com', 'hotmail.com', 'outlook.com'].include? contact["email"] 

  offer = contact["introsOffered"].values.sum
  ranking += offer

  contact["ranking"] = ranking
  puts "****************#{contact}****************"
end
