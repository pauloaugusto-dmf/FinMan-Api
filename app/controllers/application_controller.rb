class ApplicationController < ActionController::API
  def authorize_user(model)
    @model = model.find(params[:id])
    return if @model.user == current_user

    unauthorized!
  end

  private

  def unauthorized!
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
