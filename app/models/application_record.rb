# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private

  def t(key, **args)
    I18n.t(key, **args)
  end

  def error_message(key, **args)
    t("app.messages.errors.#{key}", **args)
  end
end
