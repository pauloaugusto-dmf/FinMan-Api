module Users
  class SessionsController < Devise::SessionsController
    respond_to :json
  end
end
