class Widget
  attr_reader :name
  attr_accessor :id

  def self.names
    %w(Sample Dummy)
  end

  def self.all
    @all ||= Widget.names.map do |name|
      Widget.new(name)
    end
  end

  def self.available(params = {})
    Widget.all.select do |widget|
      widget.available?(params)
    end
  end

  def self.find(_name)
    result = Widget.all.find do |widget|
      widget.name == _name
    end
    raise ActiveRecord::RecordNotFound unless result
    result
  end

  def available?(params = {})
    policy.available?(params)
  end

  def options
    defaults = {
      delay: 0,
      width: 300,
      height: 200,
    }
    defaults.merge policy.options
  end

  def initialize(_name, options = {})
    @name = _name
  end

  def policy
    "Widgets::#{name}::Policy".classify.constantize
  end

  def template
    "#{name.underscore}/content"
  end

  def content
    WidgetsController.render template, locals: { widget: self }
  end
end