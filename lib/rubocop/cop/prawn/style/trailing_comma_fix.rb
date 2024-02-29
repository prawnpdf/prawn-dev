# frozen_string_literal: true

module RuboCop
  module Cop
    module Prawn
      module Style
        module TrailingCommaFix
          def should_have_comma?(style, node)
            if style == :prawn_comma
              node.loc.begin.line != node.loc.end.line # parens are on different lines
            else
              super
            end
          end
        end
      end
    end
  end
end
