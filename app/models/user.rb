class User < ApplicationRecord
    has_one :address
    has_one :profile
    has_many :transactions
    has_many :loyalty_tier
end
