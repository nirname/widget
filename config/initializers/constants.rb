unless ENV['WIDGET_API_URL']
  STDERR.puts 'WIDGET_API_URL must be set'
  exit 1
end
