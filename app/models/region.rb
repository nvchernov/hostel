class Region < ActiveRecord::Base
  belongs_to :country, :dependent => :destroy
  has_many :cities, :dependent => :delete_all
end













