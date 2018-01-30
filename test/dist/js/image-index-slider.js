(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var ImageIndexSlider = function () {
  function ImageIndexSlider(el) {
    var _this = this;

    _classCallCheck(this, ImageIndexSlider);

    this.element = el;
    this.carousel = el.querySelector('.image-index-slider__carousel');
    this.links = el.querySelectorAll('.image-index-slider-cell__link');
    this.thumbnails = el.querySelectorAll('.image-index-slider-cell__thumbnail');

    // Flickity (Carousel)
    this.flickity = new Flickity(this.carousel, this.flickityOptions());

    // The Flickity "is-draggable" class clashes with CommnoSpot
    this.changeDraggableClass();

    // A click event to stop photoSmart triggering when dragging
    this.lastFlickityStaticClickCellEIndex = false;

    this.links.forEach(function (link, i) {
      link.addEventListener('click', function (evt) {
        if (i !== _this.lastFlickityStaticClickCellEIndex) {
          evt.stopImmediatePropagation();
          evt.preventDefault();
        }
      });
    });

    this.flickity.on('staticClick', function (evt, pntr, cell, i) {
      _this.lastFlickityStaticClickCellEIndex = i;
    });

    this.flickity.on('dragStart', function (evt, pntr, cell, i) {
      _this.lastFlickityStaticClickCellEIndex = null;
    });

    // The smartPhoto really needs a selector; nothing else will do
    this.smartPhoto = new smartPhoto('#' + this.element.id + ' .image-index-slider-cell__link');

    this.smartPhoto.on('change', function () {
      _this.flickity.select(_this.smartPhoto.data.currentIndex, false, true);
    });
  }

  _createClass(ImageIndexSlider, [{
    key: 'changeDraggableClass',
    value: function changeDraggableClass() {
      // CommonSpot uses the is-draggalbe class on a global level
      // It needs to be changed for use in this instance
      this.element.querySelectorAll('.is-draggable').forEach(function (el) {
        el.classList.remove('is-draggable');
        el.classList.add('is-luggable');
      });
    }
  }, {
    key: 'flickityOptions',
    value: function flickityOptions() {
      var options = {};

      // This seems to be required whenever I use images
      options.imagesLoaded = true;

      // The default styling hinders usage somewhat
      // Custom styling is possible, but they're really unnecessary
      options.pageDots = false;

      // The buttons are useful
      options.prevNextButtons = true;

      if (this.element.hasAttribute('data-auto-play')) {
        var autoPlay = this.element.getAttribute('data-auto-play');
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
  }]);

  return ImageIndexSlider;
}();

exports.default = ImageIndexSlider;

},{}],2:[function(require,module,exports){
'use strict';

var _imageIndexSlider = require('./image-index-slider.js');

var _imageIndexSlider2 = _interopRequireDefault(_imageIndexSlider);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('.image-index-slider').forEach(function (el) {
    new _imageIndexSlider2.default(el);
  });
});

},{"./image-index-slider.js":1}]},{},[2]);
