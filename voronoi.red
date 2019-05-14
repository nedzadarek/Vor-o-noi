Red [
    author: "Nędza Darek"
    version: 0.0.1
    subversion: `alpha
    license: %license.md
]

make-voronoi-image: function [
  distance-function [function!] "function [...] [...] or :f"
  height
  width
  sites
  colors
][
  ; no Red's version
  ; move to 'helper' file
  array: function [n /initial init] [
    bl: make block! n
    if initial [
      repeat ind n [
        append/only bl init
      ]
    ]
  ]
  ; array/initial 10 does [random 42]
  ; array/initial 10 does [array/initial 10 0]

  voronoi: array/initial width does [
    array/initial height 0
  ]
  img: make image! to-pair reduce [width height]

  unless empty? sites [
    repeat height-index (height - 1) [
        repeat width-index width [
          ; print [
          ;   'height-index height-index
          ;   'width-index width-index
          ;   'width width
          ;   'height height
          ; ]
          point-index: to-pair reduce [width-index height-index]
          distances: calculate-distances :distance-function point-index sites
          voronoi/:width-index/:height-index: ind: index? minimum-of distances
          img/(height-index * width + width-index): colors/:ind
        ]
    ]
  ]
  m: #()
  m/image: img
  m/voronoi: voronoi
  return m
]
minimum-of: function [series [series!]][
  min-value: series
  forall series [
    if series/1 < min-value/1 [
      min-value: series
    ]
  ]
  min-value
]
minimum-of [4 3 5 3 2 8]

calculate-distances: function [
  fun [function!]
  point
  sites
][
  distances: copy []
  ; print "Point: "
  ; probe point
  foreach site sites [
    ; print "Site: "
    ; probe site
    append distances (fun point site)
  ]
]
; f: function [a b] [
;   square-root ((a/x - b/x) ** 2) + ((a/y - b/y) ** 2)
; ]
; ; f 10x10 20x10
; calculate-distances :f 10x10 [10x1 20x10 12x32]

; make-voronoi-image :f 100 100 [ 20x20 40x40 33x66] reduce [red blue green]
