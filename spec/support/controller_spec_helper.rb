# frozen_string_literal: true

module ControllerSpecHelper
  # rubocop:disable Metrics/MethodLength
  def self.included(base)
    base.class_eval do
      let(:regular_user) { factories.users.build(master: false) }
      let(:current_user) { regular_user }
      let(:admin_user) { factories.users.build(master: true) }
      let(:skip_login) { false }

      before do
        unless skip_login
          login_user(current_user)
        end
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  def login_user(user)
    allow(controller).to receive(:current_user).and_return(user)
  end
end
