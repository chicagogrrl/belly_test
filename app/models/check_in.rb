class CheckIn < ActiveRecord::Base
  include Napa::FilterByHash

  validates :user, :business, presence: true
  validate :minimum_time_constraint

  def user_last_check_in
    CheckIn.where( user: self.user ).last
  end

  def minimum_time_constraint
    if user_last_check_in && user_last_check_in.created_at > 1.hour.ago
      errors.add(:user, "#{self.user} has checked in within the hour.")
    end
  end

end
