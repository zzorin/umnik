class UsersController < ApplicationController

  def search
    search_url = URI.encode("#{Settings['profile.users_url']}?term=#{params[:term]}")

    result = RestClient::Request.execute(
      method: :get,
      url: search_url,
      timeout: nil,
      headers: {
        Accept: 'application/json'
      }
    ) do |response, request, result, &block|
      response
    end

    render json: result rescue {}
  end

end
