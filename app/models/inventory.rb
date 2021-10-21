class Inventory < ActiveRecord::Base
  mount_uploader :file, FileUploader

  has_many :inventory_users, dependent: :destroy
  has_many :users, through: :inventory_users
  has_many :items, dependent: :destroy

  validates :year, presence: true
  validates :campus, presence: true
  validates :file, presence: true

  def progress
    total = self.items.count
    total_checked = self.items.where(verified: true).count
    return (total_checked * 100) / total
  rescue
    return 0
  end

  def remaining
    count_checked = self.items.where(verified: true).count
    count_remaining = self.items.where(verified: false).count
    count_items = self.items.count
    return "(total: #{count_items}, verificados: #{count_checked}, resntantes: #{count_remaining})"
  end
end
