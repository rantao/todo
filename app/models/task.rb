class Task < ActiveRecord::Base
  attr_accessible :item, :completed, :list_id
  belongs_to :list
end
