class OrderName < ApplicationRecord
  belongs_to :user
  belongs_to :system_name
  has_many :classification_names, dependent: :destroy
end
