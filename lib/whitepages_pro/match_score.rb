require 'httparty'
require 'whitepages_pro'

module WhitepagesPro
  module MatchScore
    def api_key(api_key)
      WhitepagesPro.api_key(api_key)
    end

    # ActiveMerchant has definition

    # :order_id - The order number
    # :ip - The IP address of the customer making the purchase
    # :customer - The name, customer number, or other information that identifies the customer
    # :invoice - The invoice number
    # :merchant - The name or description of the merchant offering the product
    # :description - A description of the transaction
    # :email - The email address of the customer
    # :currency - The currency of the transaction. Only important when you are using a currency that is not the default with a gateway that supports multiple currencies.
    # :billing_address - A hash containing the billing address of the customer.
    # :shipping_address - A hash containing the shipping address of the customer.

    # The :billing_address, and :shipping_address hashes can have the following keys:

    # :name - The full name of the customer.
    # :company - The company name of the customer.
    # :address1 - The primary street address of the customer.
    # :address2 - Additional line of address information.
    # :city - The city of the customer.
    # :state - The state of the customer. The 2 digit code for US and Canadian addresses. The full name of the state or province for foreign addresses.
    # :country - The [ISO 3166-1-alpha-2 code](www.iso.org/iso/country_codes/iso_3166_code_lists/english_country_names_and_code_elements.htm) for the customer.
    # :zip - The zip or postal code of the customer.
    # :phone - The phone number of the customer.

    def match_score(money, creditcard, options)
      name = (options[:billing_address] && options[:billing_address][:name]) ||
        (options[:shipping_address] && options[:shipping_address][:name])

      billing_address_street = get_street options[:billing_address]
      billing_address_zip = get_zip options[:billing_address]
      billing_phone = get_phone options[:shipping_address]

      shipping_address_street = get_street options[:shipping_address]
      shipping_address_zip = get_zip options[:shipping_address]
      shipping_phone = get_phone options[:shipping_address]

      WhitepagesPro.match_score(name, billing_address_street, billing_address_zip, billing_phone,
                                shipping_address_street, shipping_address_zip, shipping_phone)
    end

    def get_street(address_info)
      return nil unless address_info
      "#{address_info[:address1]} #{address_info[:address2]}"
    end

    def get_zip(address_info)
      return address_info[:zip] if address_info[:zip]
      return "#{address_info[:city]} #{address_info[:state]}"
    end

    def get_phone(address_info)
      address_info[:phone]
    end
  end
end
