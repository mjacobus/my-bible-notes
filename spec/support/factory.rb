# frozen_string_literal: true

class TestFactories
  class Factory
    attr_reader :factories

    def initialize(factories)
      @factories = factories
      @sequency = 0
    end

    def next_sequency
      @sequency += 1
    end

    def sequency
      @sequency ||= 0
    end

    def random
      model_class.order('RANDOM()').first
    end

    def random_or_create(overrides = {})
      random || create(overrides)
    end

    def seq
      sequency
    end

    def create(overrides = {})
      next_sequency
      model_class.create!(attributes(overrides))
    end

    def build(overrides = {})
      next_sequency
      model_class.new(attributes(overrides))
    end

    private

    def model_class
      @model_class ||= self.class.to_s.sub('TestFactories::', '').sub('Factory', '').constantize
    end
  end
end
