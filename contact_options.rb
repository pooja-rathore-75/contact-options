require 'json'

class ContactOptions
  def initialize(file_path)
    @file_path = file_path
    @contacts = load_contacts
    calculate_rankings
  end

  def load_contacts
    json_data = File.read(@file_path)
    JSON.parse(json_data)
  end

  def calculate_rankings
    @contacts.each do |contact|
      ranking = 3
      ranking += 2 unless ['gmail.com', 'hotmail.com', 'outlook.com'].include?(contact['email'])

      intros_offered = contact['introsOffered'].values.sum
      ranking += intros_offered

      contact['ranking'] = ranking
    end
  end

  def contact_option
    max_ranking = max_ranking_without_vip_intro
    offer_intro(max_ranking)
  end

  def max_ranking_without_vip_intro
    contacts_not_offered_vip_intro = @contacts.reject { |contact| contact['introsOffered']['vip'] > 0 }
    contacts_not_offered_vip_intro.map { |contact| contact['ranking'] }.max
  end

  def offer_intro(max_ranking)
    @contacts.each do |contact|
      intro_type = (contact['ranking'] == max_ranking) ? 'VIP' : 'free'
      contact['contactOption'] = intro_type
    end
  end

  def sort_contacts
    contact_option
    @contacts.sort_by { |contact| contact['name'].split.last.downcase }
  end

  def display_contacts(sorted_contacts)
    sorted_contacts.each do |contact|
      puts "*****************Contact Details**************************"
      puts "Name: #{contact['name']}"
      puts "Email: #{contact['email']}"
      puts "Ranking: #{contact['ranking']}"
      puts "Contact Option: #{contact['contactOption']}"
      puts "Offer #{contact["contactOption"]} introduction to #{contact['name']}"
    end
  end
end

contact_options = ContactOptions.new('contact_options.json')
sorted_contacts = contact_options.sort_contacts
contact_options.display_contacts(sorted_contacts)
