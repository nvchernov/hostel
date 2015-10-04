class Hotel < ActiveRecord::Base
  belongs_to :city
  scope :id_name, -> {select(:id, :name)}
end
