cb.decorateGalleries = () ->
  $('.cb-type-img_gal').on 'click', '._imageContainer figure', () ->
    cb.openGalleryModal($(this).closest('._imageContainer'))