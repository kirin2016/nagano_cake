class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:
      [:last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :postal_code,
      :prefecture_code,
      :address_city,
      :address_street,
      :address_building,
      :telephone_number,
      :email,
      :is_active,
      :created_at,
      :updated_at])
  end

end
