class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :inventory_users, dependent: :destroy
  has_many :inventories, through: :inventory_users
  has_many :items

  validates :name, presence: true
end
