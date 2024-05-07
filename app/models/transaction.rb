class Transaction < ApplicationRecord
  belongs_to :user
  after_create :generate_loyalty_tier

  private
  
  def loyalty_tier
    user = self.user
    if self.amount >= 100
      points_earned = (self.amount / 100).floor * 10
      user.loyalty_tier.create(points: points_earned)
    end
  end
end
