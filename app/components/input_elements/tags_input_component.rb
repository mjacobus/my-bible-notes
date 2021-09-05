# frozen_string_literal: true

module InputElements
  class TagsInputComponent < ApplicationComponent
    has :form
    has :form_builder
    has :name
    has :suggestions

    def tags
      form.send(name).split(',').map(&:strip)
    end

    def placeholder
      t('app.messages.tags_placeholder')
    end

    def tags_suggestions
      profile_owner.tags.scripture
    end

    def serialized_suggestions
      tags_suggestions.pluck(:name).to_json
    end
  end
end
