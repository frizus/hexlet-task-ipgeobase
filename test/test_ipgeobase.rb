# frozen_string_literal: true

require "test_helper"

class TestIpgeobase < Minitest::Test
  def setup
    uri_template = Addressable::Template.new "http://ip-api.com:80/xml/{ip}"
    stub_request(:any, uri_template).
      to_return do |request|
      ip = uri_template.extract(request.uri)["ip"]
      {
        body: File.read(__dir__ + "/xml/ip-api-body.xml").sub!("%ip%", ip)
      }
    end

    @ip_meta = ::Ipgeobase.lookup("8.8.8.8")
  end

  def test_has_data
    refute_nil(@ip_meta)
  end

  def test_lat_matches_google
    assert_equal("39.03", @ip_meta.lat)
  end
end
