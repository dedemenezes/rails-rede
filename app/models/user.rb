class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, uniqueness: { scope: :last_name }
  validates :email, uniqueness: { case_sensitive: false }

  has_one_attached :avatar

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def admin?
    admin
  end
end
