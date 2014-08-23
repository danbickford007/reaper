class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable


  before_create :available?

  def available?
    exists = `ls / | grep -Fx #{username}`.present?
    if exists 
      errors.add(:base, "Username already exists")
      false
    else
      `sudo mkdir /#{username}`
    end
  end


end
