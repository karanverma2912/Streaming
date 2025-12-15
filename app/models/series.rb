class Series < ApplicationRecord
  # Association
  has_many :seasons, dependent: :destroy
  has_many :episodes, through: :seasons

  # atachment
  has_one_attached :cover
  has_one_attached :banner
  has_one_attached :screenshots

  enum :status, { ongoing: 0, completed: 1, upcoming: 2 }
  enum :genre, { action: 0, romance: 1, comedy: 2, drama: 3, horror: 4, fantasy: 5, scifi: 6 }
end
