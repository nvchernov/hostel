class Country < ActiveRecord::Base
  has_many :regions, :dependent => :delete_all

end
