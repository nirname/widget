class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def integration
  end

  def example
  end

  def documentation
  end

  def insert
    respond_to do |format|
      format.js
    end
  end

  private

  def allow_iframe
    # response.headers['X-Frame-Options'] = 'ALLOW-FROM localhost'
    response.headers.except! 'X-Frame-Options'
  end
end
