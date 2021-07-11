class Lvpro < ApplicationRecord
  belongs_to :user

  validates :lv,presence: true,numericality: {only_integer: true,less_than: 100,greater_than: 0}
  validates :experience_point,presence: true
end
