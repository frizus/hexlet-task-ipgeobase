# frozen_string_literal: true

require_relative "ipgeobase/version"
require "faraday"

module Ipgeobase
  class Error < StandardError; end

  def self.lookup(ip)
    raise Error, "not implemented"
    # response = Faraday.get('http://ip-api.com/xml/123.123.123.124')
  end
end
