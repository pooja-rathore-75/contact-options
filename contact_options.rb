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
      puts "Offer #{intro_type} introduction to #{contact['name']}"
    end
  end
end

contact_options = ContactOptions.new('contact_options.json')
contact_options.contact_option
