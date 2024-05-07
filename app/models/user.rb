class User < ApplicationRecord
    has_one :address
    has_one :profile
end
