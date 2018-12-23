# frozen_string_literal: true

class Constants
  NO_4_CONNECTED = [
    [],
    [],
    [],
    [],
    %i[r g r g r g r],
    %i[r g g r g r g],
    %i[r g r g r g r]
  ].freeze

  CONNECTED_4_UP_RIGHT = [
    [nil, nil, nil, :g],
    [nil, nil, nil, :g],
    [nil, nil, nil, :g],
    [nil, nil, nil, :g],
    [nil, nil, nil, nil],
    [nil, nil, nil, nil],
    [nil, nil, nil, nil]
  ].freeze

  DIAGONALE_ALTERNATE_SIGN = [
    [nil, nil, nil, :g],
    [nil, nil, :g],
    [nil, :g],
    [:g],
    [],
    [],
    []
  ].freeze

  DIAGONALE_RIGHT_DOWN = [
    [:r],
    [nil, :r],
    [nil, nil, :r],
    [nil, nil, nil, :r],
    [],
    [],
    []
  ].freeze

  DIAGONALE_RIGHT_UP = [
    [],
    [],
    [],
    [nil, nil, nil, :r],
    [nil, nil, :r],
    [nil, :r],
    [:r]
  ].freeze

  CONNECTED_HORIZONTAL = [
    [],
    [],
    [],
    [],
    [],
    [],
    %i[r r r r]
  ].freeze

  CONNECTED_VERTICAL = [
    [],
    [],
    [],
    [:r],
    [:r],
    [:r],
    [:r]
  ].freeze
end
