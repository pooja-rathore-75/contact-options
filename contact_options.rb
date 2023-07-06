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

contacts_not_offered_vip_intro = contacts.reject { |contact| contact["introsOffered"]["vip"] > 0 }
max_ranking = contacts_not_offered_vip_intro.map { |contact| contact["ranking"] }.max

contacts.each do |contact|
  if contact["ranking"] == max_ranking
    puts "Offer VIP introduction to #{contact[:name]}"
  else
    puts "Offer free introduction to #{contact[:name]}"
  end
end
