class ObservationStation < ActiveRecord::Base
  has_many :observations, dependent: :destroy

  def to_s
    "#{name} | Location: #{lat}, #{lon}"
  end

end
