class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments, as: :commenter
  has_many :projects

  def self.current_user
    RequestStore.store[:current_user]
  end

  def self.current_user=(usr)
    RequestStore.store[:current_user] = usr
  end
end
