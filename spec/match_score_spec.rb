require 'spec_helper'
require 'activemerchant'

describe WhitepagesPro::MatchScore do
  describe 'requests' do
    it 'should return a payload for match score' do
      # test gateway
      ActiveMerchant::Billing::Base.mode = :test

      credit_card = ActiveMerchant::Billing::CreditCard.new(
                                                            :number     => '4111111111111111',
                                                            :month      => '8',
                                                            :year       => '2015',
                                                            :first_name => 'Matt',
                                                            :last_name  => 'Woodward',
                                                            :verification_value  => '123'
                                                            )
      expect(credit_card.valid?).to eq(true)

      # Create a gateway object to the TrustCommerce service
      gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
                                                                  :login    => 'TestMerchant',
                                                                  :password => 'password'
                                                                  )

      billing_address = {
        :name =>      'Matt Woodward',
        :address1 =>  '1835 73rd Ave NE',
        :city =>      'Medina',
        :state =>     'WA',
        :zip =>       '98039',
        :phone =>     '4254138445',
      }

      shipping_address = {
        :name =>      'Matt Woodward',
        :address1 =>  '1301 5th Ave',
        :address2 =>  'Suite 1600',
        :city =>      'Seattle',
        :state =>     'WA',
        :zip =>       '98101',
        :phone =>     '2069735100',
      }

      order = {
        :order_id =>         '1234',
        :ip =>               '192.168.1.1',
        :customer =>         'c118e792',
        :invoice =>          '230',
        :merchant =>         'SuperTrain, Inc.',
        :description =>      'ticket purchase',
        :email =>            'mwoodward@whitepages.com',
        :currency =>         'USD',
        :billing_address =>  billing_address,
        :shipping_address => shipping_address,
      }

      gateway.extend(WhitepagesPro::MatchScore)

      gateway.api_key APIKey.get_api_key

      ms_response = gateway.match_score(1000, credit_card, order)

      expect(ms_response).not_to eq(nil)


      # authorize for $10

      response = gateway.authorize(1000, credit_card, order)

      if response.success?
        # capture
        gateway.capture(1000, response.authorization, order)
      end
    end

    it 'should not return a payload outside of the US' do
    end

  end
end
