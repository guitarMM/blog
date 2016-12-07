class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :posts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #usernameを必須とする
  validates_uniqueness_of :name
  validates_presence_of :name

  validates :name,
    uniqueness: { case_sensitive: :false },
    length: { minimum: 2, maximum: 30 }

end
