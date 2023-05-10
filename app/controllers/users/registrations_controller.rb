module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      register_success && return if resource.persisted?

      register_failed(resource)
    end

    def register_success
      render json: { user: resource.as_json }
    end

    def register_failed(resource)
      render json: resource.errors, status: :unprocessable_entity
    end

    def sign_up_params
      params.require(:user).permit(:email, :password, :name)
    end
  end
end
