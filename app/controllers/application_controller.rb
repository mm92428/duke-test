# Should be super class for all this apps controllers
class ApplicationController < ActionController::API
  def status
    render json: { status: 'ok', environment: Rails.env }
  end
end
