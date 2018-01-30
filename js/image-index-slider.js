export default class ImageIndexSlider {
  constructor (el) {
    this.element = el;
    this.carousel = el.querySelector('.image-index-slider__carousel');
    this.links = el.querySelectorAll('.image-index-slider-cell__link');
    this.thumbnails = el.querySelectorAll('.image-index-slider-cell__thumbnail');

    // Flickity (Carousel)
    this.flickity = new Flickity(this.carousel, this.flickityOptions());

    // The Flickity "is-draggable" class clashes with CommnoSpot
    this.changeDraggableClass();

    // A click event to stop photoSmart triggering when dragging
    this.lastFlickityStaticClickCellEIndex =  false;

    this.links.forEach((link, i) => {
      link.addEventListener('click', evt => {
        if (i !== this.lastFlickityStaticClickCellEIndex) {
          evt.stopImmediatePropagation();
          evt.preventDefault();
        }
      });
    });

    this.flickity.on('staticClick', (evt, pntr, cell, i) => {
      this.lastFlickityStaticClickCellEIndex = i;
    });

    this.flickity.on('dragStart', (evt, pntr, cell, i) => {
      this.lastFlickityStaticClickCellEIndex = null;
    });

    // The smartPhoto really needs a selector; nothing else will do
    this.smartPhoto = new smartPhoto(`#${this.element.id} .image-index-slider-cell__link`);

    this.smartPhoto.on('change', () => {
      this.flickity.select(this.smartPhoto.data.currentIndex, false, true);
    });
  }

  changeDraggableClass () {
    // CommonSpot uses the is-draggalbe class on a global level
    // It needs to be changed for use in this instance
    this.element.querySelectorAll('.is-draggable').forEach(function (el) {
      el.classList.remove('is-draggable');
      el.classList.add('is-luggable');
    });
  }

  flickityOptions () {
    let options = {};

    // This seems to be required whenever I use images
    options.imagesLoaded = true;

    // The default styling hinders usage somewhat
    // Custom styling is possible, but they're really unnecessary
    options.pageDots = false;

    // The buttons are useful
    options.prevNextButtons = true;

    if (this.element.hasAttribute('data-auto-play')) {
      let autoPlay = this.element.getAttribute('data-auto-play')
      // Assume auto play values of less than 1 second are erroneous
      if (autoPlay < 1000) {
        autoPlay *= 1000;
      }
      options.autoPlay = autoPlay;
    }

    // Because only 1 image at a time is being shown
    options.contain = false;

    return options;
  }

}
