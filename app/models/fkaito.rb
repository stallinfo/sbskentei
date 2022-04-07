class Fkaito < ApplicationRecord
  belongs_to :fukusu
  belongs_to :user
  belongs_to :kmondai
  belongs_to :fmondai
end
