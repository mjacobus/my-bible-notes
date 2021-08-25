# frozen_string_literal: true

class TestFactories
  module Timeline
    class EventFactory < TestFactories::Factory
      def create(overrides = {})
        next_sequency
        ::Timeline::Event.new(attributes(overrides))
      end

      def attributes(overrides = {})
        from = overrides[:from] || sequency
        to = overrides[:to] || sequency + 10

        {
          title: overrides[:title] || "#{from}_#{to}",
          time: ::Timeline::Time.new(
            from: ::Timeline::Year.new(from),
            to: ::Timeline::Year.new(to)
          ),
          explanation: overrides[:explanation] || "the explanation #{sequency}"
        }
      end
    end
  end
end