class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  before_create :check_exists?

  def available?
    exists = `ls / | grep #{username}`.present?
    if exists 
      errors.add(:base, "Username already exists")
      false
    else
      `sudo mkdir /#{username}`
    end
  end


end
