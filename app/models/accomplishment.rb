class Accomplishment < ApplicationRecord
	belongs_to :user
	default_scope -> { order(date: :desc) }
	validates :user_id, presence: true
	validates :name, presence: true, length: { maximum: 60 }
	validates :timeWorking, presence: true, numericality: { greater_than_or_equal_to: 5 }
	validates :timeProductive, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validate :time_productive_leq_working

	def time_productive_leq_working
	  errors[:base] << "Time productive must be less than or equal to the amount of time productive (both in minutes)." unless timeWorking > timeProductive
	end
end
