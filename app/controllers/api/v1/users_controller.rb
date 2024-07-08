# frozen_string_literal: true
require 'jwt'

module Api
  module V1
    class UsersController < ApplicationController
      def login
        if params.dig(:user, :name).present?
          user = User.find_by_name(params.dig(:user, :name))
          token = JWT.encode user, nil, 'none'
          user.update(token: token)
          render json: { token: token }
        else
          render json: { token: nil }, status: :unprocessable_entity
        end
      end

      # create a user
      def create
        user = User.create(user_params)
        if user.persisted?
          render json: { name: user.name }, status: :created
        else
          render json: { name: user.name }, status: :unprocessable_entity
        end
      end

      # current user information
      def current
        return render status: :unprocessable_entity if params.dig(:token).blank?
        user = User.find_by_token(params.dig(:token))
        render json: { name: user.name }
      end

      def user_params
        params.require(:user).permit(:name)
      end
    end
  end
end