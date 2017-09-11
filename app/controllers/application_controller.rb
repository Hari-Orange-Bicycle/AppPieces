class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  ActsAsTaggableOn.delimiter=[',',' ']
  before_action { |c| User.current_user = c.current_user }

  protected
    def after_sign_in_path_for(resource)
      projects_path
    end
end
