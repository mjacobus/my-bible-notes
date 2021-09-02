# frozen_string_literal: true

module Base
  module CurrentUser
    extend ActiveSupport::Concern

    private

    def current_user
      get(:current_user) || helpers.current_user
    end

    def visitor
      current_user || GuestUser.new
    end
  end
end
