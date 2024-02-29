# frozen_string_literal: true

require 'rubocop'
require_relative 'prawn/style/trailing_comma_fix'

RuboCop::Cop::Style::TrailingCommaInArguments.prepend(RuboCop::Cop::Prawn::Style::TrailingCommaFix)
RuboCop::Cop::Style::TrailingCommaInArrayLiteral.prepend(RuboCop::Cop::Prawn::Style::TrailingCommaFix)
RuboCop::Cop::Style::TrailingCommaInBlockArgs.prepend(RuboCop::Cop::Prawn::Style::TrailingCommaFix)
RuboCop::Cop::Style::TrailingCommaInHashLiteral.prepend(RuboCop::Cop::Prawn::Style::TrailingCommaFix)

%w[
  Style/TrailingCommaInArguments
  Style/TrailingCommaInArrayLiteral
  Style/TrailingCommaInBlockArgs
  Style/TrailingCommaInHashLiteral
].each do |cop_name|
  RuboCop::ConfigLoader.default_configuration[cop_name]['SupportedStylesForMultiline']&.append('prawn_comma')
end
