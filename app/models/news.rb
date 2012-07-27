class News < ActiveRecord::Base
  def read?
    status == 1
  end

  def read=(val=true)
    update_attribute(status: 1) if val
  end
end
