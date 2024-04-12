# frozen_string_literal: true

require "test_helper"

class TestIpgeobase < Minitest::Test
  def test_request
    stub_ip_location_service

    begin
      ip_meta = ::Ipgeobase.lookup("8.8.8.8")
    rescue StandardError
      assert(false, "Выпало исключение")
    end

    refute_nil(ip_meta)
    assert_equal("success", ip_meta.status)
    assert_equal("US", ip_meta.country_code)
  end

  def stub_ip_location_service
    uri_template = Addressable::Template.new "http://ip-api.com:80/xml/{ip}"
    stub_request(:any, uri_template)
      .to_return do |request|
      ip = uri_template.extract(request.uri)["ip"]
      {
        body: File.read("#{__dir__}/test_ipgeobase_mock.xml").sub!("%ip%", ip)
      }
    end
  end
end
