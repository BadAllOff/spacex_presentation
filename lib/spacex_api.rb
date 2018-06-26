require 'httparty'
require 'json'

class SpacexApi
  include HTTParty
  base_uri 'api.spacexdata.com/v2/'

  def rockets
    get('/rockets')
  end

  def launches
    get('/launches')
  end

  private

  def get(path)
    parse(self.class.get(path))
    rescue HTTParty::Error
      {}
    rescue StandardError
      {}
  end

  def parse(response)
    if response.code == 200
      JSON.parse(response.body)
    else
      {}
    end
  end
end
