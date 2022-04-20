class SystemName < ApplicationRecord
  belongs_to :user
  has_many :order_names, dependent: :destroy
end
