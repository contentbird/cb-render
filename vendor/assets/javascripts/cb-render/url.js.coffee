cb.decorateUrls = () ->
  $('.cb-type-url').each () ->
    cb.decorateUrl $(this)

cb.decorateUrl = (widget) ->
  url                  = widget.find('a').attr('href')
  [playerName, itemId] = identifyPlayerAndItemId(url)
  if playerName?
    widget.empty()
    renderPlayer(widget, playerName, itemId)

identifyPlayerAndItemId = (url) ->
  return ['youtube',    RegExp.$1] if url.match /^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/
  return ['soundcloud', url      ] if url.match /^(?:https?:\/\/)?(?:www\.)?soundcloud\.com\/.*$/
  return [null,         null]

renderPlayer = (widget, playerName, itemId) ->
  data = {}
  data.itemId = itemId

  player = $(tmpl("cb-template-player-#{playerName}", data))
  $(widget).html(player)