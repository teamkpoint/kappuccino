class KapsulesController < ApplicationController
  before_filter :requires_oauth_access_token

  def index
    @kapsules = Kapsule.send "get_#{type}"
  end

  private
  def type
    params[:type]
  end
end
