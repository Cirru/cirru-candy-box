body#app
  #location
    span.dir (:v-repeat stack)
      = "{{$value}}"
  #candy-box
    .candy (:v-repeat currentScope)
      .key $ span (:v-model "$key")
      .value $ span
        :v-class "foundType($value != null ? $value : $data)"
        :v-model "escapeType($value != null ? $value : $data)"
  input#input
    :autofocus
    :v-model command
    :placeholder Type Commands...
    :v-on "keydown:confirm | key enter"
      , ", keydown:prevCommand | key up"
      , ", keydown:nextCommand | key down"