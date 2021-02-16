class Room < ApplicationRecord
  has_many :reservation
  mount_uploader :room_image, ImageUploader
  validates :name, {presence:true, length:{maximum: 20}}
  validates :introduction, {presence:true, length:{maximum: 200}}
  validates :fee, {presence:true}
  validates :address, {presence:true, length:{maximum: 100}}
  validates :room_image, {presence:true}
  
  def self.search(area,keyword)
    #return Room.all unless area && keyword
    if area && keyword.empty?
      Room.where(['address LIKE ? ', "%#{area}%"])
    elsif keyword && area.empty?
      Room.where(['name LIKE ? OR introduction LIKE ? ', "%#{keyword}%", "%#{keyword}%"])
    else
      Room.where(['address LIKE ? OR name LIKE ? OR introduction LIKE ? ', "%#{area}%", "%#{keyword}%", "%#{keyword}%"])
    end
  end
    
end
