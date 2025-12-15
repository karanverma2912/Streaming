class Season < ApplicationRecord
  belongs_to :series
  has_many :episodes, dependent: :destroy
end
