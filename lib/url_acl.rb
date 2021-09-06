# frozen_string_literal: true

class UrlAcl
  SimplifiedRequest = Struct.new(:params)

  PUBLIC_URLS = [
    '/',
    '/logout',
    '/profile',
    '/:profile/scriptures',
    '/:profile/timelines',
    '/:profile/tags'
  ].freeze

  def initialize(url)
    @url = url
  end

  def authorized?(user)
    url = @url.sub(user.username.to_s, ':profile')

    if PUBLIC_URLS.include?(url)
      return true
    end

    params = Rails.application.routes.recognize_path(@url.to_s)
    ControllerAcl.new(SimplifiedRequest.new(params)).authorized?(user)
  end
end
