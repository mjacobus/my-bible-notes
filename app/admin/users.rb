# frozen_string_literal: true

ActiveAdmin.register Db::User do
  permit_params :master, :enabled, controller_accesses: []

  index do
    selectable_column
    column :name
    column :email
    column :enabled
    column :master
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name, input_html: { disabled: true }
      f.input :email, input_html: { disabled: true }
      f.input :master
      f.input :enabled
      f.input :controller_accesses, as: :check_boxes,
                                    collection: ControllerAcl.controller_actions_for_acl
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :avatar do |user|
        image_tag user.avatar
      end
      row :master
      row :enabled
      row :permission_config
      row :created_at
      row :updated_at
      row :controller_accesses do |user|
        ul do
          user.controller_accesses.sort.each do |controller_action|
            li controller_action
          end
        end
      end
    end
  end
end
