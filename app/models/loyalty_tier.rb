class LoyaltyTier < ApplicationRecord
  belongs_to :user
  
  after_create :update_user_status, :generate_reward_for_user

  enum status: { active: 0, redeemed: 1, expired: 2 }

  scope :created_in_current_month, -> { where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month) }

  private

  def generate_reward_for_user
    user = self.user
    loyalty_tiers = user.loyalty_tiers.active.created_in_current_month
    issue_free_coffe_reward if loyalty_tiers.pluck(:points.sum) > 100
  end

  def issue_free_coffe_reward
    user = self.user
    user.reward.create(reward_type: "Free Coffee", dicount_percentage: 100, description: "User can buy free coffee from store.")
  end

  def update_user_status
    user = self.user
    total_points = user.loyalty_tiers.pluck(:points).sum
  
    case total_points
    when 1001..5000
      user.profile.update(status: 1)
    when 5001..
      user.profile.update(status: 2)
    end
  end  
end
