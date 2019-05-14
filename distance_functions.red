Red [
    author: "Nędza Darek"
    version: 0.0.1
    subversion: `alpha
    license: %license.md
]

float-div: make op! function [a b] [
  (to-float a) / b
]
float-mult: make op! function [a b] [
  (to-float a) * b
]
distance-functions: reduce [
  "euclidean" func [point1 point2][
    square-root (  (power (point1/1 - point2/1) 2) + (power (point1/2 - point2/2) 2) )
  ]
  "manhatan" func [point1 point2] [
    (absolute(point1/1 - point2/1)) + (absolute (point1/2 - point2/2))
  ]
  "rand-manhatan" func [point1 point2] [
    ret: (absolute(point1/1 - point2/1)) + (absolute (point1/2 - point2/2))
    ; ret + random 20.0
    ret * (0.9 + random 0.2)
  ]
  "canberra" func [point1 point2][
    ((absolute(point1/1 - point2/1)) float-div (absolute(point1/1 + point2/1))) + ((absolute (point1/2 + point2/2)) float-div (absolute (point1/2 + point2/2)))
  ]
  "chebyszev" func [point1 point2][
    max (absolute (point2/1 - point1/1)) (absolute (point2/2 - point1/2))
  ]
  "cosine-corelation" func [point1 point2][
    ((point1/1 float-mult point2/1) + (point1/2 float-mult point2/2)) float-div square-root (((power point1/1 2) + (power point1/2 2)) float-mult ((power point2/1 2) + (power point2/2 2)))
  ]
  "bray-curtis" func [point1 point2] [
    (absolute (point1/1 - point2/1) + (absolute (point1/2 - point2/2))) float-div (point1/1 + point2/1 + point1/2 + point2/2)
  ]

  ; function that takes more than 2 arguments (points) &
  ; function that use other functions
  ; will be implemented later
  ; "minkowski" func [point1 point2 p][
  ;   (power (absolute (point1/1 - point2/1) ) p) + (power (absolute (point1/2 - point2/2)) (1 / p))
  ; ]
  ; "minkowski-3" func [point1 point2] [
  ;   distance-minkowski point1 point2 3
  ; ]
  ; "minkowski-6" func [point1 point2] [
  ;   distance-minkowski point1 point2 6
  ; ]
  ; "minkowski-1" func [point1 point2] [
  ;   select distances "minkowski" point1 point2 1
  ; ]
  ; "minkowski-2" func [point1 point2] [
  ;   distance-minkowski point1 point2 2
  ; ]

  "random" func [point1 point2][
    (random 200 float-mult 100) float-div 100
  ]
  "foo" func [point1 point2][
    absolute (point2/1 - point1/1)
  ]
  "foo2" func [point1 point2][
    absolute (point2/2 - point1/2)
  ]
  "foo3" func [point1 point2][
    (absolute (point2/2 - point1/1) + (absolute (point2/1 - point1/2)))
  ]
  ; faster function - old: ~18, new: ~15
  ; distance2: func [point1 point2][
  ;   square-root (  (t1: point1/1 - point2/1) float-mult t1 + ( (t2: point1/2 - point2/2) float-mult t2 ) )
  ;
  ; ]
  "karlsruhe" function [point1 point2][
    ; Karlsruhe-metric Voronoi diagram is drawn by using distance function d(p,p(i))
    ; If 0<=s<=2, d(p,p(i))=q*e(s,s(i))+|r-r(i)|} ; else d(p,p(i))=r+r(i)
    ; where (r,s) is the polar coordinate of p, (r(i),s(i)) is the polar coordinate of
    ; p(i),
    ; |a| is a sign of absolute value,
    ; q is min(r,r(i)),
    ; e(s,s(i)) is min(|s-s(i)|,6.28-|s-s(i)|).
    r: function [point] [square-root ( (point/x ** 2) + (point/y ** 2) )]

    phi: function [point] [arctangent2 point/y point/x]
    e: function [phi phi2] [
      min
        absolute phi - phi2
        6.28 - absolute phi - phi2
    ]
    _r1: r point1
    _r2: r point2
    ; print reduce [point1 point2]
    _phi1: phi point1
    _phi2: phi point2

    either all [
      0.0 <= _phi1
      _phi1 <= 2
    ][
      _m: min
        absolute (_phi1 - _phi2)
        6.28 - (absolute (_phi1 - _phi2))
      _m * (e _phi1 _phi2) + absolute _r1 - _r2
    ][
      _r + _r1
    ]
  ]
  "rand-karlsruhe" function [point1 point2][
    ; Karlsruhe-metric Voronoi diagram is drawn by using distance function d(p,p(i))
    ; If 0<=s<=2, d(p,p(i))=q*e(s,s(i))+|r-r(i)|} ; else d(p,p(i))=r+r(i)
    ; where (r,s) is the polar coordinate of p, (r(i),s(i)) is the polar coordinate of
    ; p(i),
    ; |a| is a sign of absolute value,
    ; q is min(r,r(i)),
    ; e(s,s(i)) is min(|s-s(i)|,6.28-|s-s(i)|).
    r: function [point] [square-root ( (point/x ** 2) + (point/y ** 2) )]

    phi: function [point] [arctangent2 point/y point/x]
    e: function [phi phi2] [
      min
        absolute phi - phi2
        6.28 - absolute phi - phi2
    ]
    _r1: r point1
    _r2: r point2
    ; print reduce [point1 point2]
    _phi1: phi point1
    _phi2: phi point2

    ret: either all [
      0.0 <= _phi1
      _phi1 <= 2
    ][
      _m: min
        absolute (_phi1 - _phi2)
        6.28 - (absolute (_phi1 - _phi2))
      _m * (e _phi1 _phi2) + absolute _r1 - _r2
    ][
      _r + _r1
    ]

    ret + random 20.0
  ]
  "min-chebyszev" func [point1 point2][
    min (absolute (point2/1 - point1/1)) (absolute (point2/2 - point1/2))
  ]
]
