# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for(flash_type)
      case flash_type
          when "success"
          "success"
          when "error"
          "danger"
          when "alert"
          "danger"
          when "notice"
          "success"
          when "danger"
          "danger"
          else
          flash_type.to_s
      end
  end
end
