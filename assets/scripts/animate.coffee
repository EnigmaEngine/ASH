wheelTimeout = 4000
waterfallPreempt = 200

waterfall = () ->
  $(".waterfall").each((i) ->
    obj = $(this).offset().top + $(this).outerHeight()
    win = $(window).scrollTop() + $(window).height()
    win += waterfallPreempt
    if win > obj
      $(this).animate({ opacity: 1, top: 0 }, 1000)
  )

# DRY is weaping at this ungodly mess.
# It's fucking 1:22 in the morning.

wheel = (curr) ->
  curr.animate(
    { opacity: 0, left: "-10em" },
    { duration: 500, "queue": false, done: () ->
      curr.hide()
      if curr.is($(".wheel").children().last())
        next = $(".wheel").children().first()
      else
        next = curr.next()
      next.show().css({ "opacity": "0", "left": "10em" }).animate(
        { opacity: 1, left: 0 },
        { duration: 500, "queue": false, done: setTimeout((() -> wheel(next)),wheelTimeout)}
      ) }
  )

# Make the suffix slide left and right to meet the length of the prefix
vWheel = (curr) ->
  curr.animate(
    { opacity: 0, top: "-1em" },
    { duration: 500, "queue": false, done: () ->
      curr.hide()
      if curr.is($(".v-wheel").children().last())
        next = $(".v-wheel").children().first()
      else
        next = curr.next()
      next.show().css({ "opacity": "0", "top": "1em" }).animate(
        { opacity: 1, top: 0 },
        { duration: 500, "queue": false, done: setTimeout((() -> vWheel(next)),wheelTimeout)}
      ) }
  )

$(document).ready(() ->
  waterfall()
  setTimeout((() -> wheel($(".wheel").children().first())), wheelTimeout)
  setTimeout((() -> vWheel($(".v-wheel").children().first())), wheelTimeout)
  $(window).scroll(() -> waterfall())
)
