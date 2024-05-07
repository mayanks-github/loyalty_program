class User < ApplicationRecord
    has_one :address
    has_one :profile
    has_many :transactions
    has_many :loyalty_tier
    has_many :rewards

    private

    def self.generate_birthday_reward
        issue_coffe_reward
    end

    def self.generate_quaterly_bonus_points
        start_of_quarter = Time.zone.now.beginning_of_quarter
        end_of_quarter = Time.zone.now.end_of_quarter
        amount = transactions.where(created_at: start_of_quarter..end_of_quarter)&.pluck(:amount)
        self.loyalty_tiers.create(points: 100) if amount > 2000
    end

    def self.accumulated_points_in_current_month
        loyalty_tiers = self.loyalty_tiers.active.created_in_current_month
        issue_coffe_reward if loyalty_tiers.pluck(:points.sum) > 100
    end

    def issue_coffe_reward
        self.reward.create(reward_type: "Free Coffee", dicount_percentage: 100, description: "User can buy free coffee from store.")
    end

    def self.issue_free_movie_ticket
        self.reward.create(reward_type: "Movie Ticket", dicount_percentage: 100, description: "A free moview tickets for your First 60 days spending.")
    end
end
