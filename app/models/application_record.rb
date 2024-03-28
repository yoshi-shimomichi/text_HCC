class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.carrierwave_store_id
    to_s.underscore
  end
end
