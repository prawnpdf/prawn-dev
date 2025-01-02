# frozen_string_literal: true

require_relative 'yard_markup/code_highlight'

module Prawn
  module Dev
    module YardMarkup
      YARD::Templates::Helpers::MarkupHelper::MARKUP_PROVIDERS[:markdown].push(
        { lib: :'prawn/dev/yard_markup/document', const: 'Prawn::Dev::YardMarkup::Document' },
      )
      YARD::Templates::Engine.register_template_path(File.expand_path('../../../templates', __dir__))

      YARD::Templates::Helpers::HtmlHelper.prepend(Prawn::Dev::YardMarkup::CodeHighlight)
    end
  end
end
