@cb = {
        author: 'contentbird',
        thumbnailUrl: (imageUrl) ->
          imageUrl.replace(/(.*)\.([a-z|A-Z]*)$/, '$1_thumb.jpg')
      }