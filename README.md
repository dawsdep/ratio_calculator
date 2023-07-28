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
- (optionally) set h & w variables in the iex session to make changes as easy as re-running "set_dimensions(%{h: h, w: w})"
- use get_state, get_visual, and set_dimensions

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

## Bonus

After aliasing all calculator functions with "import RatioCal" and setting h and w variables in the iex session you can change h and/or w values and then re-run...

- "set_dimensions(%{h: h, w: w}) && get_state([:ratio])"
- "set_dimensions(%{h: h, w: w}) && get_visual()"
- "set_dimensions(%{h: h, w: w}) && get_visual() && get_state()"
- "set_dimensions(%{h: h, w: w}) && get_visual() && get_state([:ratio])"
