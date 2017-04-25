class Port < ApplicationRecord
    validates :title, presence: true
    validates :target, presence: true
end
