class Project < ActiveRecord::Base

  before_create :available?
  before_destroy :kill

  def kill
    username = User.find(user_id).username
    `sudo rm -r /#{username}/#{name}.git` 
  end

  def available? 
    username = User.find(user_id).username
    exists = `ls /#{username}/ | grep -Fx #{name}.git`.present?
    if exists 
      errors.add(:base, "Project already exists")
      false
    else
      self.url = "#{username}/#{name}.git"
      `sudo mkdir /#{username}/#{name}.git`
      `sudo chmod -R 777 /#{username}/#{name}.git`
      `cd /#{username}/#{name}.git && sudo git --bare init`
    end
  end

  def branches
    `git branch`
  end

  def open
    username = User.find(user_id).username
    exists = `ls /#{username}/ | grep -Fx #{name}_temp`.present?
    if exists 
      username = User.find(user_id).username
      `sudo rm -r /#{username}/#{name}_temp` 
    end
    `sudo mkdir /#{username}/#{name}_temp && sudo chmod -R 777 /#{username}/#{name}_temp && git clone /#{username}/#{name}.git /#{username}/#{name}_temp/`
    `ls /#{username}/#{name}_temp/`
  end

end
