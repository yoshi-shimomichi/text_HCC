Rails.application.config.to_prepare do
  HighVoltage::PagesController.skip_before_action :require_login
end