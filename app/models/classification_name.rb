class ClassificationName < ApplicationRecord
  belongs_to :user
  belongs_to :order_name
  has_many :kmondais, dependent: :destroy
end
