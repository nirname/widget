module Widgets::Dummy::Policy
  def self.available?(params = {})
    false
  end

  def self.options
    {}
  end
end