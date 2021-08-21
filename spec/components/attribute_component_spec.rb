# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttributeComponent, type: :component do
  let(:html) { rendered_component }

  it 'renders block' do
    render(component) { 'Hi there' }

    expect(html).to have_text('Hi there')
  end

  it 'includes bem and adicional classes' do
    render(component.with_classes('another-class')) { 'Text' }

    expect(html).to have_css('span.AttributeComponent')
    expect(html).to have_css('span.another-class')

    expect(html).to have_css('.AttributeComponent', text: 'Text')
    expect(html).to have_css('.AttributeComponent__text', text: 'Text')
  end

  it 'does not include lable by default' do
    render(component)

    expect(html).not_to have_css('.AttributeComponent--label')
  end

  it 'can include label' do
    render(component.with_label('hello world'))

    expect(html).to have_css('.AttributeComponent__label', text: 'hello world')
  end

  it 'can include localizable label' do
    render(component.with_label('name'))

    expect(html).to have_css('.AttributeComponent__label', text: 'Nome')
  end

  it 'can change container and classes' do
    render(component.wrap_with(:div, { class: 'hey' }))

    expect(html).to have_css('div.hey.AttributeComponent')
  end

  it 'does not include icon by default' do
    render(component)

    expect(html).not_to have_css('i.bi')
  end

  it 'can include icon' do
    render(component.with_icon(:hey))

    expect(html).to have_css('i.bi.bi-hey')
  end

  it 'can include link' do
    render(component.with_link('/foo/bar')) { 'with link' }

    expect(html).to have_css('a[href="/foo/bar"]', text: 'with link')
  end

  def component
    described_class.new
  end

  def render(component, &block)
    if block
      render_inline(component, &block)
    end

    render_inline(component) { 'test' }
  end
end
