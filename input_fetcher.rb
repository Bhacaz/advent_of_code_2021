# frozen_string_literal: true
require 'net/http'
require 'cgi'

class InputFetcher
  class << self
    def day(day)
      file_path = "day#{day.to_s.rjust(2, '0')}/input.txt"
      if File.exist?(file_path)
        File.read(file_path)
      else
        download_input(day, file_path)
      end
    end

    private

    def token
      File.read('token.txt')
    end

    def download_input(day, file_path)
      uri = URI("https://adventofcode.com/#{Time.now.year}/day/#{day}/input")
      http = Net::HTTP.new(uri.host, 443)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      cookie = CGI::Cookie.new('session', token)
      request['Cookie'] = cookie.to_s
      content = http.request(request).body
      File.write(file_path, content)
      content
    end
  end
end
