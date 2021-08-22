# frozen_string_literal: true

# rubocop:disable RSpec/AnyInstance
module RequestSpecHelper
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def self.included(base)
    base.class_eval do
      let(:regular_user) do
        factories.users.create(enabled: true, master: false, username: 'regular')
      end
      let(:current_user) { regular_user }
      let(:admin_user) { factories.users.create(enabled: true, master: true, username: 'admin') }
      let(:skip_login) { false }
      let(:factories) { TestFactories.new }
      let(:routes) { Routes.new }

      before do
        unless skip_login
          login_user(current_user)
        end
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def login_user(user)
    allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
  end

  def grant_access(user, actions: ['*'])
    controller = described_class.to_s.underscore.sub('_controller', '')
    actions.each do |action|
      user.grant_controller_access(controller, action: action)
    end
  end

  def mock_renderer
    allow_any_instance_of(ApplicationController).to receive(:render) do |instance, template, args|
      instance.send(:response_body=, 'rendered by mock renderer')
      renderer.render(template, args)
    end
  end

  def renderer
    @renderer ||= MockRenderer.new(self)
  end

  class MockRenderer
    def initialize(spec)
      @spec = spec
      @rendered_templates = []
      @rendered_options = []
    end

    def render(template, options)
      @rendered_templates.push(template)
      @rendered_options.push(options)
    end

    def has_rendered_component?(component)
      @spec.expect(@rendered_templates.last).to @spec.be_equal_to(component)
    end
  end
end
# rubocop:enable RSpec/AnyInstance
