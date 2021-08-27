# frozen_string_literal: true

module ApplicationHelper
  def response_failed(model)
    model['error'] || model['errors']
  end
end
