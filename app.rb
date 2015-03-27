require 'sinatra'
require 'net/http'
require 'json'
require 'date'

get '/' do
  gov = current_government
  return gov['title'] if gov
  "There is no government, right now."
end

def current_government
  response = Net::HTTP.get_response(URI.parse("https://www.gov.uk/api/governments"))
  latest = JSON.parse(response.body)['results'].first
  end_date = latest['details']['end_date']
  latest unless end_date && Date.parse(end_date) <= Date.today
end
