class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authorize_user(model)
    @model = model.find(params[:id])
    return if @model.user == current_user

    unauthorized!
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def unauthorized!
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
