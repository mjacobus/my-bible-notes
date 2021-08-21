# frozen_string_literal: true

class CopyToClipboardComponent < ApplicationComponent
  def default_selector
    @default_selector ||= "clipboard-#{UniqueId.new}"
  end

  def selector
    @options[:selector]
  end
end
