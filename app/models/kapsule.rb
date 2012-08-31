require 'rubygems'
require 'rest_client'
require 'json'
require 'ostruct'

class Kapsule < OpenStruct
  class << self
    ['popular', 'recent', 'mustsee'].each do |type|
      send :define_method, "get_#{type}".to_sym do
        response = RestClient.get("http://#{APP_CONFIG['kpoint_host']}/api/v1/xapi/kapsules/#{type}?first=0&max=10&oauth_token=#{AccessToken.current.token}")
        response_hash = JSON.parse(response)
        response_hash["list"].collect{|k| Kapsule.new(k)}
      end
    end
  end


  def initialize(attribute_hash={})
    super(attribute_hash)
  end
end

