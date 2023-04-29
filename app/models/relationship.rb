class Relationship < ApplicationRecord
  belongs_to :active_follow, class_name: "User"
  belongs_to :passive_follow, class_name: "User"
end
