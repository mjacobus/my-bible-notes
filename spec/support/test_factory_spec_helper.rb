# frozen_string_literal: true

module TestFactorySpecHelper
  def self.included(base)
    base.class_eval do
      let(:factories) { TestFactories.new }
    end
  end
end
