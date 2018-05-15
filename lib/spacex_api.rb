require 'httparty'
require 'json'

class SpacexApi
  include HTTParty
  base_uri 'api.spacexdata.com/v2/'

  def rockets
    self.class.get('/rockets')
  end

  def launches
    self.class.get('/launches')
  end
end
