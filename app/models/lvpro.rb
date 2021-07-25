class Lvpro < ApplicationRecord
  belongs_to :user

  validates :lv,presence: true,numericality: {only_integer: true,greater_than: 0}
  validates :experience_point,presence: true
end
