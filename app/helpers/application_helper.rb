module ApplicationHelper
  def sample_widget_params
    JSON.parse File.read(Rails.root.join('test', 'fixtures', 'requests', 'sample.json'))
  end

  def app_host
    ENV["APP_HOST"]
  end

  def app_port
    ENV['APP_PORT']
  end
end
