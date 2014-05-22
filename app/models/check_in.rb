class CheckIn < ActiveRecord::Base
  include Napa::FilterByHash

  validates :user, :business, presence: true
  validate :minimum_time_constraint

  def user_last_check_in
    CheckIn.where(user: user, business: business).last
  end

  def minimum_time_constraint
    return unless user_last_check_in
    return unless user_last_check_in.created_at > 1.hour.ago
    errors.add(:user, "#{user} has checked in within the hour.")
  end

end
