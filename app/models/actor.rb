class Actor < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :gender, presence: true, length: { maximum: 6 }, inclusion: { in: ['Male', 'Female'] }
end
