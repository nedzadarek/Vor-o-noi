hilber-curve: [
  [6 7 10 11]
  [5 8 9 12]
  [4 3 14 13]
  [1 2 15 16]
]

sites: [
  1x2 1x4 3x3
]

hilbert2d-to-1d: function [block [block!]] [
  ret: copy []
  m: #()

  ; let's just assume that this is a block of NxN dimension
  repeat y (l: length? block) [
    repeat x (l) [
      m/(block/:y/:x): to-pair reduce [y x]
    ]
  ]

  repeat n (l * l) [
    append ret m/:n
  ]
  return ret
]
curve1d: hilbert2d-to-1d hilber-curve
sites1d: copy []
foreach site sites [
  append sites1d index? find curve1d site
]
sort sites1d

length1d: length? curve1d
voronoi1d: make block! length1d
repeat _ length1d [
  append voronoi1d none
]
; 1 to first site:
repeat n first sites1d [
  voronoi1d/:n: 1
]
; after the last site:
voronoi1d/(last sites1d): length? sites1d
repeat n (length1d - last sites1d) [
  voronoi1d/( (last sites1d) + n): length? sites1d
]
voronoi1d


forall sites1d [
  unless 1 = length? sites1d [
    repeat a half: (sites1d/2 - sites1d/1 / 2) [
      voronoi1d/(sites1d/1 + a): probe index? sites1d
    ]
    repeat b half [
        voronoi1d/(sites1d/1 + half + b): probe (1 + index? sites1d)
    ]
  ]
]
voronoi1d

voronoi2d: copy/deep hilber-curve
repeat y (length? voronoi2d) [
  repeat x (length? voronoi2d/:y) [
    voronoi2d/:y/:x: voronoi1d/(voronoi2d/:y/:x)
  ]
]
voronoi2d
; == [
;     [1 1 2 2]
;     [1 1 1 2]
;     [1 1 3 3]
;     [1 1 3 3]
; ]
