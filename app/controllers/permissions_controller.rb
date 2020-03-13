class PermissionsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new; end

  def create
  end

  def destroy
  end

  private

  def contest_params
    params.require(:permission).permit(:user_id, :context_type, :context_id, :role)
  end
end
