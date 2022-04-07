class Fukusu < ApplicationRecord
  belongs_to :user
  has_many :kmondais
  has_many :fusers, dependent: :destroy
  has_many :fkaitos, dependent: :destroy
  has_many :fmondais, dependent: :destroy
end
