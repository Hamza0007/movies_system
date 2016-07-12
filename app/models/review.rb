class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  def show_email
    self.user.email
  end

end
