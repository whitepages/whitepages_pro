require 'httparty'
require 'json'

module WhitepagesPro

  class WhitepagesPro
    include HTTParty
    base_uri 'https://proapi.whitepages.com'
#    debug_output

    def WhitepagesPro.api_key(api_key)
      @@api_key = api_key
    end

    def WhitepagesPro.get_default_options
      {}.tap do | options |
        options["api_key"] = @@api_key
        options["outputtype"] = "JSON"
      end
    end

    def WhitepagesPro.result(response)
      return nil unless response.code == 200
      JSON.parse response.body
    end


    def WhitepagesPro.match_score(name = nil, billing_address_street = nil, billing_address_zip = nil, billing_phone = nil, shipping_address_street = nil, shipping_address_zip = nil, shipping_phone = nil)
      query = get_default_options
      query["name"] = name if name
      query["billing_address_street"] = billing_address_street if billing_address_street
      query["billing_address_zip"] = billing_address_zip if billing_address_zip
      query["billing_phone"] = billing_phone if billing_phone
      query["shipping_address_street"] = shipping_address_street if shipping_address_street
      query["shipping_address_zip"] = shipping_address_zip if shipping_address_zip
      query["shipping_phone"] = shipping_phone if shipping_phone

      result get("/match_score/1.1/", :query => query)

    end

    def WhitepagesPro.reverse_address(street, where)
      query = get_default_options
      query["street"] = street
      query["where"] = where

      result get("/reverse_address/1.1", :query => query)
    end

    def WhitepagesPro.reverse_phone(phone)
      query = get_default_options
      query["phone"] = phone
      result get("/reverse_phone/1.1", :query => query)
    end

    def WhitepagesPro.find_person(name, where, metro = true)
      query = get_default_options
      query["metro"] = metro ? 1 : 0
      query["name"] = name
      query["where"] = where

      result get("/find_person/1.1", :query => query)
    end

    def WhitepagesPro.find_business(keywords, where)
      query = get_default_options
      query["keywords"] = keywords
      query["location"] = where

      result get("/find_business/1.1", :query => query)
    end
  end
end
