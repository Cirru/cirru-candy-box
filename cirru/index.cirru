
doctype
html
  head
    title $ = Cirru Candy Box
    meta (:charset utf-8)
    link (:rel stylesheet)
      , (:type text/css) (:href css/style.css)
    script (:defer)
      :src build/build.js
  
  @partial candy-box.cirru