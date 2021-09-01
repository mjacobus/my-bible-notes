# frozen_string_literal: true

class TestFactories
  # rubocop:disable Style/MissingRespondToMissing:
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

    def valid_random_id_or(first_option = nil)
      first_option || random_or_create.id
    end

    def seq
      sequency
    end

    def create(overrides = {})
      next_sequency
      model_class.create!(attributes(overrides))
    rescue ActiveRecord::RecordInvalid => e
      p e.record.errors.to_h
      raise
    end

    def build(overrides = {})
      next_sequency
      model_class.new(attributes(overrides))
    end

    def method_missing(method, *args)
      factories.send(method, *args)
    end

    private

    def model_class
      @model_class ||= self.class.to_s.sub('TestFactories::', '').sub('Factory', '').constantize
    end
  end
  # rubocop:enable Style/MissingRespondToMissing:
end
