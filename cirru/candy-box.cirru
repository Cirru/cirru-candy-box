body#app
  #location
    span
      :v-model location
  #candy-box
    .candy
      :v-repeat theScope
      .key
        :v-model "$key"
      .value
        :v-class "foundType($value)"
        :v-model "escapeType($value)"
  input#input
    :autofocus
    :v-model command
    :v-on "keydown:confirm | key enter"
      , ", keydown:prevCommand | key up"
      , ", keydown:nextCommand | key down"