class News < ActiveRecord::Base
  def read?
    status == 1
  end

  def mark_as_read
    update_attribute(:status, 1)
  end
end
