class Hotel < ActiveRecord::Base
  belongs_to :city, :dependent => :destroy
  scope :id_name, -> {select(:id, :name)}
end
