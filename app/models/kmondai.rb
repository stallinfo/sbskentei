class Kmondai < ApplicationRecord
    has_many :kchoices, dependent: :destroy
    has_many :dailyexcercises, dependent: :destroy
    has_many :kenteikaitou, dependent: :destroy
    belongs_to :classification_name
end
