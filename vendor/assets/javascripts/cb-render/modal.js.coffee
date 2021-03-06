cb.decorateModal = () ->
  $('body').on 'click touchend', '.modal-overlay, #modal ._close', (event) ->
    cb.closeModal()
    event.preventDefault()
  $('body').on 'click', '._openLargeModal', (event) ->
    cb.openLargeAjaxModal($(this).attr('href'))
    event.preventDefault()

cb.openAjaxModal = (url, caller) ->
  $.get url, (data) =>
    $('#modal').html(data).show()
    openModal(caller)

cb.openLargeAjaxModal = (url, caller) ->
  $('#modal').addClass('largebox')
  cb.openAjaxModal(url, caller)

cb.openGalleryModal = (caller) ->
  caller = caller.closest('._imageContainer')
  displayImageZoom(caller)
  decorateGalleryNavLinks()
  $('#modal').addClass('lightbox')
  openModal(caller.closest('._images'))

cb.closeModal = () ->
  $('#modal').removeClass('show lightbox largebox')

openModal = (caller) ->
  cb.modal_caller = caller
  $('#modal').addClass('show')

displayImageZoom = (caller) ->
  allImages = caller.parent().children()
  index = allImages.index(caller)
  maxIndex = allImages.length - 1

  data = {}
  data.imageUrl       = caller.data('image')
  data.imageLegend    = caller.data('legend')
  data.previousIndex  = if index == 0 then maxIndex else (index - 1)
  data.nextIndex      = if index == maxIndex then 0 else (index + 1)

  imageZoom = $(tmpl("cb-template-image-gallery", data))
  $('#modal').html(imageZoom).show()

decorateGalleryNavLinks = () ->
  $('#modal').on 'click', '#previousImage,#nextImage', (e) ->
    targetIndex = $(this).data('target-index') || 0
    targetImage = $(cb.modal_caller.children('._imageContainer')[targetIndex])
    displayImageZoom(targetImage)
    e.preventDefault()
