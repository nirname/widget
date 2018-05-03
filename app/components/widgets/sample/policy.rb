module Widgets::Sample::Policy
  def self.available?(params = {})
    false
  end

  def self.options
    {
      delay: 0
    }
  end
end