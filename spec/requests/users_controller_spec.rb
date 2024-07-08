require 'rails_helper'

describe Api::V1::UsersController, type: 'request' do
  let(:json_headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json'} }

  describe 'Users Controller' do
    # it 'should respond successfuly' do
    #   get '/api/v1/users', headers: json_headers
    #   expect(response.status).to eq(200)
    #   expect(response.body).to be
    #   expect(response.body).not_to eq('null')
    #   returned_configs = JSON.parse(response.body)
    #   expect(returned_configs).to be_a Hash
    # end

    it "creates a User" do
        headers = { "ACCEPT" => "application/json" }
        post "/api/v1/users", :params => { :user => {:name => "jamil" } }, :headers => headers
    
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:created)
    end
    it "does not create a User" do
        headers = { "ACCEPT" => "application/json" }
        post "/api/v1/users", :params => { :user => {:name => nil } }, :headers => headers
    
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:unprocessable_entity)
    end

    it "user logs in and gives a token" do
        user = User.create(name: 'Jamil')
        headers = { "ACCEPT" => "application/json" }
        post "/api/v1/users/login", :params => { :user => {:name => user.name } }, :headers => headers
    
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:success)
    end
    it "User does not login" do
        headers = { "ACCEPT" => "application/json" }
        post "/api/v1/users/login", :params => { :user => {:name => nil } }, :headers => headers
    
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:unprocessable_entity)
    end

    it "user logs in and gives a token" do
        user = User.create(name: 'Jamil')
        headers = { "ACCEPT" => "application/json" }
        post "/api/v1/users/login", :params => { :user => {:name => user.name } }, :headers => headers
    
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:success)
    end
    it "User does not login" do
        headers = { "ACCEPT" => "application/json" }
        post "/api/v1/users/login", :params => { :user => {:name => nil } }, :headers => headers
    
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:unprocessable_entity)
    end
    it "user gets its info" do
        user = User.create(name: 'Jamil')
        headers = { "ACCEPT" => "application/json" }
        post "/api/v1/users/login", :params => { :user => {:name => user.name } }, :headers => headers
        #post "/api/v1/users/current", :params => { token: response.token  }, :headers => headers
        
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:success)
    end
  end
end
