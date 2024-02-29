# frozen_string_literal: true

def stylesheets_full_list
  super + %w[css/syntax-highlight.css]
end

def file(basename, allow_inherited = false)
  if basename == 'css/syntax-highlight.css'
    require('rouge')
    Rouge::Theme.find('magritte').render
    [
      '.highlighter-rouge',
    ].map { |scope|
      Rouge::Theme.find('github.light').render(scope: scope)
    }.join("\n")
  else
    super
  end
end
