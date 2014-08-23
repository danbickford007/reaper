class Directory

  def self.exists?(name)
    Dir.mkdir name
  end

end
