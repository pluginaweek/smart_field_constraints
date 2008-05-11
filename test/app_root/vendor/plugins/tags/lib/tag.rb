class Tag < ActiveRecord::Base
  validates_length_of :name, :maximum => 30
end
