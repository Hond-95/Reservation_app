class Reservation < ApplicationRecord
    belongs_to :room
    
    validates :start_ymd, {presence:true}
    validates :end_ymd, {presence:true}
    validates :guests, {presence:true}
end
