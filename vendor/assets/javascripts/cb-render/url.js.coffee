cb.decorateUrls = () ->
  $('.cb-type-url').each () ->
    cb.decorateUrl $(this)

cb.decorateMarkdownLinks = () ->
  $('.cb-type-markdown').each () ->
    cb.decorateUrl $(this)

cb.decorateUrl = (zone) ->
  links = zone.find('a')
  links.each () ->
    [playerName, itemId] = identifyPlayerAndItemId($(this).attr('href'))
    if playerName?
      renderPlayer($(this), playerName, itemId)

identifyPlayerAndItemId = (url) ->
  return ['youtube',    RegExp.$1]                  if url.match /^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/
  return ['dailymotion',    RegExp.$1]              if url.match /^(?:https?:\/\/)?(?:www\.)?dailymotion.com\/video\/([^_&#\/]+).*$/
  return ['soundcloud', url      ]                  if url.match /^(?:https?:\/\/)?(?:www\.)?soundcloud\.com\/.*$/
  return ['spotify', RegExp.$1.replace(/\//g, ':')] if url.match /^(?:https?:\/\/)?(?:open\.)?spotify\.com\/(.*)$/
  if url.match /^(?:https?:\/\/)?(?:www\.)?deezer\.com\/(track|playlist|album)\/(\d*)$/
    type = RegExp.$1
    id   = RegExp.$2
    if type == 'track'
      type   = 'tracks'
      list   = false
      height = 80
    else
      list   = true
      height = 300
    return ['deezer', {type: type, id: id, list: list, height: height}]
  return [null,         null]

renderPlayer = (link, playerName, itemId) ->
  data = {}
  data.itemId = itemId

  player = $(tmpl("cb-template-player-#{playerName}", data))
  link.after(player)