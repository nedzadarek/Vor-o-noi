Red[]
l: layout[
  do [
    _temp-num: none
    number-of-colors: 0
    select-data: function [
      list
    ] [
      select list/data to-string list/selected
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
  color-list: text-list data [] on-change [
    color-list-preview/color: s: select-data color-list
    color-tab-red/data: s/1
    color-tab-green/data: s/2
    color-tab-blue/data: s/3
  ]

  color-list-preview: base red 100x30
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
view/no-wait l
