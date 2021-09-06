# frozen_string_literal: true

module Tags
  class IndexPageComponent < ApplicationComponent
    has :collection

    def menu
      @menu ||= IndexMenuComponent.new(
        current_user: current_user,
        profile_owner: profile_owner
      )
    end
  end
end
