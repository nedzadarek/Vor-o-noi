Red [
    author: "Nędza Darek"
    version: 0.0.1
    subversion: `alpha
    license: %license.md
]

do %voronoi.red
do %distance_functions.red
do %colors.red

main-layout: [
  do [
    image-size: 300x300
    sites: copy []
    colors: copy []
    distance-function: func [a b] [make error! "no distance function selected"]
    computed-voronoi: #()
    computed-voronoi/image: copy []
    computed-voronoi/voronoi: copy []
  ]
  my-panels: tab-panel 700x600 [

    "Sites" [
      sites-image: base silver draw [] with [size: image-size] [
        append sites event/offset
        sites-area/text: mold/only sites
        append face/draw _next-point: compose [
          ellipse
          (event/offset)
          3x3
        ]
        append voronoi-image/draw _next-point
      ]
      return
      sites-area: area wrap
      return

      button "Set sites" [
        sites: to-block sites-area/text

        _sites-draw: copy []
        foreach site sites [
          append _sites-draw compose [
            ellipse
            (site)
            3x3
          ]
        ]
        sites-image/draw: _sites-draw

        voronoi-image/draw: _sites-draw

      ]
      button "Clear sites" [
        clear sites
        clear sites-image/draw
        sites-area/text: copy ""

        voronoi-image/draw: copy []
      ]
    ]

; first line is empty!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    "Voronoi" [
      do [
        calculate-and-show-voronoi: [
          computed-voronoi: make-voronoi-image
            :distance-function
            image-size/x image-size/y
            sites
            create-random-colors colors length? sites

          voronoi-image/image: computed-voronoi/image
        ]
      ]

      voronoi-image: base silver all-over draw [] with [
        size: image-size
      ] on-over [
        ; put event/offset into word
        unless any [ event/offset/x < 0  event/offset/y < 0] [
          voronoi-position/data: event/offset
          ; CATCH NON-EXISTENT POINTS (E.G. BY CHANGED SIZE OR SOMETHING)!!!!!!!!!!!!!!!!!!!!!!!
          unless empty? computed-voronoi/voronoi [ ; it's empty when it's not computed (no sites or not yet computed)
            voronoi-site/data: computed-voronoi/voronoi/(event/offset/x)/(event/offset/y)
          ]
          
        ]
      ]
      return

      text "POSITION:"
      voronoi-position: text "0x0"
      return

      text "SITE:"
      voronoi-site: text "-"
      return

      panel [
        field "search[TO BE DONE]"
        button "calc voronoi" calculate-and-show-voronoi
        return
        distance-list: text-list 200x130 pink on-create [
          face/data: distance-functions
        ] on-change [
          distance-function: :distance-list/data/(distance-list/selected * 2)
          distance-function-code/text: mold :distance-list/data/(distance-list/selected * 2)
          distance-function-name/text: distance-list/data/(distance-list/selected * 2 - 1)
        ]
        ; return
      ]
    ]
    "Distances" [
      panel[
        distance-function-code: area wrap
        distance-function-name: field "name"
        button "save change [TBD]"
        button "add distance function [TBD]"
      ]
      return

      distances-distance-list: text-list 200x300 pink on-create [
        face/data: distance-functions
      ] on-change [
        distance-function-code/text: mold :distances-distance-list/data/(distances-distance-list/selected * 2)
        distance-function-name/text: distances-distance-list/data/(distances-distance-list/selected * 2 - 1)
      ]
    ]
    "Colors" [
      do [
        _temp-num: none
        number-of-colors: 0
        select-data: function [
          list
        ] [
          select list/data to-string list/selected
        ]
        change-colors: function [
          colors
        ][
          clear colors
          foreach [_ind color] color-list/data [
            append colors color
          ]
        ]
        color-tab-change: function [
          ind "1:red 2:green 3:blue"
          field
        ][
          _h: find/tail color-list/data (to-string color-list/selected)
          _h/1/:ind: field/data
          ; BUG:  if I don't `show color-list` elements will disapear:
          show color-list
          color-list-preview/color: _h/1
        ]
        randomize-color: function [
          color-list-index
        ][
          _h: find/tail color-list/data (to-string color-list-index)
          _h/1: random 255.255.255
          show color-list
        ]
        update-color-tabs-and-preview: function [

        ][
          _h: find/tail color-list/data (to-string color-list/selected)
          color-tab-red/data:   _h/1/1
          color-tab-green/data: _h/1/2
          color-tab-blue/data:  _h/1/3
          color-list-preview/color: _h/1
        ]
      ]
      color-list: text-list data [] silver on-change [
        color-list-preview/color: s: select-data color-list
        color-tab-red/data: s/1
        color-tab-green/data: s/2
        color-tab-blue/data: s/3
        change-colors colors
      ]

      color-list-preview: base red 100x100 draw [
        ; what to do here?!
        ; some colors like 67.33.30 appears different (lighter/darker) when surrounded by colors

      ]
      panel [
        text "Red"
        color-tab-red: field on-change [
          color-tab-change 1 color-tab-red
        ]
        return

        text "Green"
        color-tab-green: field on-change [
          color-tab-change 2 color-tab-green
        ]
        return

        text "Blue"
        color-tab-blue: field on-change [
          color-tab-change 3 color-tab-blue
        ]
        return

      ]
      panel [
        style wide-button: button 120
        wide-button "add color"  [
          number-of-colors: number-of-colors + 1
          append color-list/data reduce [
            to-string number-of-colors
            0.0.0
          ]
          color-list/selected: number-of-colors
        ] return
        wide-button "randomize selected" [
          randomize-color color-list/selected
          update-color-tabs-and-preview
        ]
        return
        wide-button "randomize all colors" [
          repeat _temp-num (divide length? color-list/data 2) [
            randomize-color _temp-num
          ]
          color-list/selected
          update-color-tabs-and-preview

        ]
        return
      ]
    ]
    "Options [working?]" [
      text "Height:"
      text "Width:"
      return
      options-height: field
      options-width: field
      return
      button "Set size" [
        sites-image/size/x: voronoi-image/size/x: image-size/x: options-width/data
        sites-image/size/y: voronoi-image/size/y: image-size/y: options-height/data
        ; COPIED FROM SITES PANEL!!!!!!!!!!!!!
        clear sites
        clear sites-image/draw
        sites-area/text: copy ""
        voronoi-image/image/rgb: silver
        voronoi-image/draw: copy []
      ]
    ]
    "Export" [
      button "Image" [
        if file: request-file/save [
          unless suffix? file [append file ".png"]
          save/as file computed-voronoi/image 'png
        ]
      ]
      button "Points" [
        if file: request-file/save [
          unless suffix? file [append file ".txt"]
          save file computed-voronoi/voronoi
        ]
      ]
      button "Sites" [
        if file: request-file/save [
          unless suffix? file [append file ".txt"]
          save file sites
        ]
      ]
    ]

  ] on-change [
    if event/picked = 4 [ ; color tab
      _ind: 0
      clear color-list/data
      foreach _color colors [
        _ind: _ind + 1
        append color-list/data to-string _ind
        append color-list/data _color
      ]
    ]

    if my-panels/selected = 4 [
      clear colors
      foreach [_ind color] color-list/data [
        append colors color
      ]
    ]
  ]
]
view/no-wait/flags main-layout [resize]
