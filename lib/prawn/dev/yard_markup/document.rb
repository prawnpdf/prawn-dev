# frozen_string_literal: true

require 'kramdown'
require 'kramdown-parser-gfm'
require 'rouge'

module Prawn
  module Dev
    module YardMarkup
      class CodeFormatter < ::Rouge::Formatter
        def initialize(opts = {})
          @opts = opts
          @formatter =
            if opts[:inline_theme]
              ::Rouge::Formatters::HTMLInline.new(opts[:inline_theme])
            else
              ::Rouge::Formatters::HTML.new
            end
        end

        def stream(tokens, &block)
          yield %(<pre><code>) unless @opts[:inline]
          @formatter.stream(tokens, &block)
          yield '</code></pre>' unless @opts[:inline]
        end
      end

      class Document < Kramdown::Document
        def initialize(source, options = {})
          super(source, default_options.merge(options))
        end

        def default_options
          {
            input: 'GFM',
            hard_wrap: false,
            syntax_highlighter: :rouge,
            syntax_highlighter_opts: {
              default_lang: 'ruby',
              block: { formatter: CodeFormatter },
              span: { formatter: CodeFormatter, inline: true },
            },
          }
        end
      end
    end
  end
end
