class Profile < ApplicationRecord
    belongs_to :user

    enum status: {standard: 0, gold: 1, platinum: 2}
end
