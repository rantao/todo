class Task < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :list
end
