cb.decorateUrls = () ->
  $('.cb-type-url').each () ->
    cb.decorateUrl $(this)

cb.decorateUrl = (zone) ->
  links = zone.find('a')
  links.each () ->
    [playerName, itemId] = identifyPlayerAndItemId($(this).attr('href'))
    if playerName?
      renderPlayer($(this), playerName, itemId)

identifyPlayerAndItemId = (url) ->
  return ['youtube',    RegExp.$1] if url.match /^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/
  return ['soundcloud', url      ] if url.match /^(?:https?:\/\/)?(?:www\.)?soundcloud\.com\/.*$/
  return [null,         null]

renderPlayer = (link, playerName, itemId) ->
  data = {}
  data.itemId = itemId

  player = $(tmpl("cb-template-player-#{playerName}", data))
  link.after(player)