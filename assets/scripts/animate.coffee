wheelTimeout = 5000

waterfall = () ->
  $(".waterfall").css({"opacity": "0", "top": "-1em"}).animate(
    { opacity: 1, top: 0 },
    { duration: 1000 }
  )

wheel = (curr) ->
  curr.animate(
    { opacity: 0, left: "-10em" },
    { duration: 500, done: () ->
      curr.hide()
      if curr.is($(".wheel").children().last())
        next = $(".wheel").children().first()
      else
        next = curr.next()
      next.show().css({ "opacity": "0", "left": "10em" }).animate(
        { opacity: 1, left: 0 },
        { duration: 500, done: setTimeout((() -> wheel(next)),wheelTimeout)}
      ) }
  )

$(document).ready(() ->
  waterfall()
  window.setTimeout((() -> wheel($(".wheel").children().first())), wheelTimeout)
)
