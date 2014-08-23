class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  before_create :check_exists?

  def check_exists?
    unless File.directory?("/#{username}")
      p FileUtils.mkdir_p("/#{username}")
      p '?????????????????'
    end
  end

end
