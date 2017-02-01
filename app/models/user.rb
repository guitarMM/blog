class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :posts
  has_many :comments

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :name
  validates_presence_of :name

  validates :name,
  uniqueness: { case_sensitive: :false },
  length: { minimum: 2, maximum: 30 }
end
