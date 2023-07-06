require 'json'
require 'rspec'
require_relative 'contact_options'

RSpec.describe ContactOptions do
  let(:file_path) { 'contact_options.json' }
  let(:contact_options) { ContactOptions.new(file_path) }

  describe '#load_contacts' do
    it 'loads contacts from the JSON file' do
      json_data = File.read(file_path)
      contact_options = JSON.parse(json_data)

      expect(contact_options).to be_an(Array)
      expect(contact_options.length).to be > 0
    end
  end

  describe '#calculate_rankings' do
    it 'calculates the rankings for each contact' do
      contact_options.calculate_rankings.each do |contact|
        expect(contact['ranking']).to be_a(Integer)
        expect(contact['ranking']).to be >= 3
      end
    end
  end

  describe '#max_ranking_without_vip_intro' do
    it 'returns the maximum ranking among contacts without a VIP intro' do
      max_ranking = contact_options.max_ranking_without_vip_intro

      contact_options.calculate_rankings.each do |contact|
        next if contact['introsOffered']['vip'] > 0

        expect(contact['ranking']).to be <= max_ranking
      end
    end
  end

  describe '#sort_contacts' do
    it 'sorts the contacts alphabetically by last name' do
      sorted_contacts = contact_options.sort_contacts

      json_data = File.read(file_path)
      contact_options = JSON.parse(json_data)

      expected_names = contact_options.map { |contact| contact['name'] }.sort_by { |name| name.split.last.downcase }
      actual_names = sorted_contacts.map { |contact| contact['name'] }

      expect(actual_names).to eq(expected_names)
    end

    it 'sets the contactOption for each contact' do
      sorted_contacts = contact_options.sort_contacts

      sorted_contacts.each do |contact|
        expect(contact['contactOption']).to eq('VIP').or(eq('free'))
      end
    end
  end
end
