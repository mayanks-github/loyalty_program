class Transaction < ApplicationRecord
  belongs_to :user
  after_create :generate_loyalty_tier

  private
  
  def generate_loyalty_tier
    user = self.user
    if self.amount >= 100
      points_earned = (self.amount / 100).floor * 10
      points_earned *= 2 if self.country != user.address.country
      user.loyalty_tier.create(points: points_earned)
    end
  end
end
