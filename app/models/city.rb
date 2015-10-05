class City < ActiveRecord::Base
  belongs_to :region, :dependent => :destroy
  has_many :hotels, :dependent => :delete_all
end
