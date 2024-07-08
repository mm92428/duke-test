require 'rails_helper'

describe ApplicationController do
  let(:json_headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json'} }

  describe 'app status when properly integrated' do
    it 'should respond successfuly' do
      get '/api/v1/app/status', headers: json_headers
      expect(response.status).to eq(200)
      expect(response.body).to be
      expect(response.body).not_to eq('null')
      returned_configs = JSON.parse(response.body)
      expect(returned_configs).to be_a Hash
    end

    it 'should return {status: ok}' do
      get '/api/v1/app/status', headers: json_headers
      returned_configs = JSON.parse(response.body)
      expect(returned_configs).to have_key('status')
      expect(returned_configs['status']).to eq('ok')
    end

    it 'should return current environment' do
      get '/api/v1/app/status', headers: json_headers
      returned_configs = JSON.parse(response.body)
      expect(returned_configs).to have_key('environment')
      expect(returned_configs['environment']).to eq(Rails.env)
    end
  end
end
