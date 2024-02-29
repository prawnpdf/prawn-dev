# frozen_string_literal: true

def stylesheets
  super + %w[css/syntax-highlight.css]
end

def file(basename, allow_inherited = false)
  puts "  >>  #{basename}"
  if basename == 'css/syntax-highlight.css'
    return 'body { background: yellow; }'
  end

  super
end
