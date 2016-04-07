require_relative "../server"
require "rspec"
require "rack/test"

describe "Server Service" do

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

end
