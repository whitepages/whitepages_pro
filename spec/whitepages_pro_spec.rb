require 'spec_helper'

describe WhitepagesPro::WhitepagesPro do
  describe 'requests' do
    it 'should return a json payload for reverse_phone' do
      WhitepagesPro::WhitepagesPro.api_key APIKey.get_api_key
      rev_phone_data = WhitepagesPro::WhitepagesPro.reverse_phone("2069735100")
      expect(rev_phone_data).not_to eq(nil)
    end

    it 'should return a json payload for find_person' do
      WhitepagesPro::WhitepagesPro.api_key APIKey.get_api_key
      find_person_data = WhitepagesPro::WhitepagesPro.find_person("bill gates", "seattle, wa")
      expect(find_person_data).not_to eq(nil)
   end

    it 'should return a json payload for match_score' do
      WhitepagesPro::WhitepagesPro.api_key APIKey.get_api_key
      match_score_data = WhitepagesPro::WhitepagesPro.match_score("Matthew Woodward", "12234 10th ave s", "98168", "2062444545", "12234 10th ave s", "98168", "2062444724")
      expect(match_score_data).not_to eq(nil)
    end

    it 'should return a json payload reverse_address' do
      WhitepagesPro::WhitepagesPro.api_key APIKey.get_api_key
      rev_address_data = WhitepagesPro::WhitepagesPro.reverse_address("1301 5th Ave", "seattle, wa")
      expect(rev_address_data).not_to eq(nil)
    end

    it 'should return a json payload for find_business' do
      WhitepagesPro::WhitepagesPro.api_key APIKey.get_api_key
      find_business_data = WhitepagesPro::WhitepagesPro.find_business("starbucks", "seattle, wa")
      expect(find_business_data).not_to eq(nil)
    end
  end
end
