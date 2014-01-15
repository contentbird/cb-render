cb.decorateGalleries = () ->
  $('.cb-type-img_gal').on 'click', '._imageContainer figure', () ->
    cb.openGalleryModal($(this).closest('._imageContainer'))
  $(document).keyup (e) ->
    switch e.which
      when 39 then $('#nextImage').click()
      when 37 then $('#previousImage').click()