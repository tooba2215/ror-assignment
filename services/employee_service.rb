require 'net/http'
require 'net/https'

class EmployeeService
  BASE_URL = 'https://dummy-employees-api-8bad748cda19.herokuapp.com/employees'.freeze

  def self.get_all(page = nil)
    uri = page ? URI("#{BASE_URL}?page=#{page}") : URI(BASE_URL)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.get_one(id)
    uri = URI("#{BASE_URL}/#{id}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.create(params)
    uri = URI(BASE_URL)
    request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
    request.body = params.to_json
    perform_request(uri, request)
  end

  def self.update(id, params)
    uri = URI("#{BASE_URL}/#{id}")
    request = Net::HTTP::Put.new(uri.path, {'Content-Type' => 'application/json'})
    request.body = params.to_json
    perform_request(uri, request)
  end

  private

  def self.perform_request(uri, request)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    response = http.request(request)
    JSON.parse(response.body)
  end
end
