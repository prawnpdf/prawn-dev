# frozen_string_literal: true

require 'kramdown'
require 'rouge'

module Prawn
  module Dev
    module YardMarkup
      module CodeHighlight
        def html_syntax_highlight_ruby(source)
          converter =
            Kramdown::Converter::Html.__send__(
              :new,
              nil,
              Prawn::Dev::YardMarkup::Document.new('').default_options,
            )

          el = Kramdown::Element.new(:codeblock, source, { lang: 'ruby' })
          converter.convert(el, 0)
        end
        alias html_markup_ruby html_syntax_highlight_ruby

        # Do nothing
        def parse_codeblocks(html)
          html
        end
      end
    end
  end
end
