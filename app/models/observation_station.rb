class ObservationStation < ActiveRecord::Base
  has_many :observations

  def to_s
    "#{name} | Location: #{lat}, #{lon}"
  end

end
