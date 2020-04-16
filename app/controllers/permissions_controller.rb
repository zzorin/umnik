class PermissionsController < ApplicationController
  load_and_authorize_resource

  def index; end

  def new; end

  def create
    @permission = Permission.new(permission_params)

    if @permission.save
      render :create
    else
      render :errors
    end
  end

  def destroy
    if @permission.destroy
      render :destroy
    else
      render :errors
    end
  end

  def available_roles; end

  private

  def permission_params
    params.require(:permission).permit(:user_id, :role, :context_type, :context_id)
  end
end
