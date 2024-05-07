class LoyaltyTier < ApplicationRecord
  belongs_to :user
  
  after_create :update_user_status
  after_create :generate_reward_for_user

  enum status: { active: 0, redeemed: 1, expired: 2 }

  scope :created_in_current_month, -> { where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month) }

  private

  def generate_reward_for_user
    user.reward.create(reward_type: "5% rebate", dicount_percentage: 5, description: "five percent rebate") if user.transactions.where("amount > 100")&.count > 10 
  end 

  def update_user_status
    total_points = user.loyalty_tiers.pluck(:points).sum
  
    case total_points
    when 1001..5000
      user.profile.update(status: 1)
    when 5001..
      user.profile.update(status: 2)
      user.reward.create(reward_type: "Lounge access", dicount_percentage: 100, description: "4x Airport Lounge Access")
    end
  end
end
