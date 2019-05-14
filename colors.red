Red [
    author: "Nędza Darek"
    version: 0.0.1
    subversion: `alpha
    license: %license.md
]

; move to 'helper' file
array: function [n /initial init] [
  bl: make block! n
  if initial [
    repeat ind n [
      append/only bl init
    ]
  ]
]
_create-random-colors: func [quantity][
  array/initial quantity does [ random 255.255.255 ]
]
create-random-colors: function ['_colors quantity][
  if quantity > length? (get _colors) [
    append get _colors _create-random-colors (quantity - (length? get _colors))
  ]
  get _colors
]
