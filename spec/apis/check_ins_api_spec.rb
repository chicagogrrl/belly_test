require 'spec_helper'

def app
  ApplicationApi
end

describe CheckInsApi do
  include Rack::Test::Methods

  describe 'GET /check_ins' do
    before {create :check_in}
    it 'returns an array of check ins' do
      get '/check_ins'
      data = JSON.parse(last_response.body)
      expect(data['data'].size).to eq(1)
    end
  end

  describe 'POST /check_ins' do
    it "should create a check in" do
      post '/check_ins', user: "Rose Tyler", business: "Starbucks"
      data = JSON.parse(last_response.body)
      expect(data['data']['object_type']).to eq('check_in')
    end

    it "should return an error when a check in repeats within the hour" do
      create :check_in, user: "Rose Tyler", business: "Starbucks"
      post '/check_ins', user: "Rose Tyler", business: "Starbucks"
      data = JSON.parse(last_response.body)
      expect(data['data']).to be_nil
      expect(data['error']['code']).to eq('record_invalid')
    end
  end

  describe "GET /check_ins/1" do
    let(:my_check_in){create :check_in}
    it "should retrieve the specified check in" do
      get "/check_ins/#{my_check_in.id}"
      data = JSON.parse(last_response.body)
      expect(data['data']['id']).to eq(my_check_in.id.to_s)
    end
  end

  describe "PUT /check_ins/1" do
    let(:my_check_in){create :check_in, user: 'Rose Tyler'}
    it "should update the specified check in" do
      expect(my_check_in.user).to eq('Rose Tyler')
      put "/check_ins/#{my_check_in.id}", user: 'Mickey Smith'
      data = JSON.parse(last_response.body)
      my_check_in.reload
      expect(my_check_in.user).to eq('Mickey Smith')
    end
  end

end
