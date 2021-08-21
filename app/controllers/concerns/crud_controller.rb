# frozen_string_literal: true

module CrudController
  extend ActiveSupport::Concern

  def index
    records = paginate(scope)
    render index_component(records)
  end

  def show
    render show_component(record)
  end

  def new
    @record = scope.new
    render form_component(record)
  end

  def create
    @record = find_scope.new
    save_record
  end

  def edit
    render form_component(record)
  end

  def update
    save_record
  end

  def destroy
    record.destroy
    redirect
  end

  private

  def index_component(records)
    if use_key?
      return component_class(:index).new(pluralized_key => records)
    end

    component_class(:index).new(records)
  end

  def show_component(record)
    if use_key?
      return component_class(:show).new(key => record)
    end

    component_class(:show).new(record)
  end

  def form_component(record)
    if use_key?
      return component_class(:form).new(key => record)
    end

    component_class(:form).new(record)
  end

  def record
    @record ||= find_scope.find(params[:id])
  end

  def model_class
    # NOOP
  end

  def find_scope
    (model_class || scope)
  end

  def save_record
    record.attributes = permitted_attributes

    if record.save
      return redirect
    end

    render form_component(record), status: :unprocessable_entity
  end

  def redirect
    redirect_to action: :index
  end

  def permitted_attributes
    params.require(key).permit(*permitted_keys)
  end

  def key
    raise 'Define key :key_name'
  end

  def pluralized_key
    raise 'Define key :key_name [:pluralized_key]'
  end

  def permitted_keys
    raise 'Define permit :attr1, :attr2...'
  end

  def scope
    raise 'Define scope { Model.all }'
  end

  def component_class(_name)
    raise "Define component_class_template 'SomeNamespace::%{type}PageComponent'"
  end

  module ClassMethods
    def model_class(model_class)
      define_method :model_class do
        model_class
      end
      private :model_class
    end

    def key(key, pluralized = nil)
      define_method :key do
        key
      end
      private :key

      define_method :pluralized_key do
        pluralized || key.to_s.pluralize.to_sym
      end
      private :pluralized_key
    end

    def permit(*args)
      define_method :permitted_keys do
        args
      end
      private :permitted_keys
    end

    def scope(&block)
      define_method :scope do
        instance_eval(&block)
      end
      private :scope
    end

    def component_class_template(value, use_key: true)
      define_method :use_key? do
        use_key
      end
      private :use_key?

      define_method :component_class do |type|
        value.sub('%{type}', type.to_s.classify).constantize
      end
      private :component_class
    end
  end
end
