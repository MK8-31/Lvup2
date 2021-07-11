class Profession < ApplicationRecord
  belongs_to :user
  validates :profession,presence:true,numericality: {only_integer: true,less_than: 3,greater_than_or_equal_to: 0}
end
