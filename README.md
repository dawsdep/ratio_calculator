# Ratio Calc

Small program to make working with ratios a bit easier.

- h / w -> percentage
- print visualization of ratio

## Usage

- After downloading & getting mix dependencies...
- cd into the ratio_calc directory
- run "iex -S mix"
- in iex start the calculator with "RatioCalc.start()"
- (optionally) alias calculator functions with "import RatioCalc"
- use set_dimensions, get_state, and get_visual

## RatioCalc.start(initial_state)

- initial_state: (optional) %{h: h, w: w}
- default_state: %{h: 9, w: 16}
- starts RatioCalculator which is required

## RatioCalc.get_state(fields)

- fields: filters state fields (optional) [:field_name_1, :field_name_2]
- prints state

## RatioCalc.get_visual()

- prints visual

## RatioCalc.set_dimensions(dimensions)

- dimensions: %{h: h, w: w}, %{h: h}, or %{w: w}
- sets dimensions and sets calculated ratio
