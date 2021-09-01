# frozen_string_literal: true

module Base
  class BreadcrumbComponent < ApplicationComponent
    def initialize
      add(t('app.links.home'), urls.root_path)
    end

    def under_profile(user)
      @profile = user
      add(user.username)
      self
    end

    def call
      render breadcrumb
    end

    private

    attr_reader :profile

    def add(label, url = nil)
      breadcrumb.add(label, url)
      self
    end

    def breadcrumb
      @breadcrumb ||= ::BreadcrumbComponent.new
    end
  end
end
