// NodeList.forEach polyfill
if (window.NodeList && !NodeList.prototype.forEach) {
  NodeList.prototype.forEach = Array.prototype.forEach;
}

(function(){
  'use strict';

  var options,
    galleries,
    carousels,
    cells,
    onDOMContentLoaded = function() {
      options = document.getElementById('options');
      galleries = document.querySelectorAll('.iis-Gallery');
      carousels = document.querySelectorAll('.iis-Carousel');
      cells = document.querySelectorAll('.iis-Cell');
      preserveOriginalClasses();
      preserverOriginalAttributes();
      applyOptions();
      options.addEventListener('keyup', onOptionsKeyUp);
    },
    onOptionsKeyUp = function() {
      applyOptions();
    },
    preserveOriginalClasses = function() {
      // Gallery
      galleries.forEach(function(gallery) {
        gallery.setAttribute('data-original-class', gallery.getAttribute('class'));
      });
      // Carousel
      carousels.forEach(function(carousel) {
        carousel.setAttribute('data-original-class', carousel.getAttribute('class'));
      });
      // Cell
      cells.forEach(function(cell) {
        cell.setAttribute('data-original-class', cell.getAttribute('class'));
      });
    },
    preserverOriginalAttributes = function() {
      galleries.forEach(function(gallery) {
        var imageTargetHeight = gallery.getAttribute('data-image-target-height'),
          autoPlay = gallery.getAttribute('data-auto-play');
        if ('undefined' !== typeof imageTargetHeight) {
          gallery.setAttribute('data-original-image-target-height', imageTargetHeight);
        }
        if ('undefined' !== typeof autoPlay) {
          gallery.setAttribute('data-auto-play', autoPlay);
        }
      });
    },
    restoreOriginalClasses = function() {
      // Gallery
      galleries.forEach(function(gallery) {
        gallery.setAttribute('class', gallery.getAttribute('data-original-class'));
      });
      // Carousel
      carousels.forEach(function(carousel) {
        carousel.setAttribute('class', carousel.getAttribute('data-original-class'));
      });
      // Cell
      cells.forEach(function(cell) {
        cell.setAttribute('class', cell.getAttribute('data-original-class'));
      });
    },
    restoreOriginalAttributes = function() {
      galleries.forEach(function(gallery) {
        var originalImageTargetHeight = gallery.getAttribute('data-original-image-target-height'),
          originalAutoPlay = gallery.getAttribute('data-original-auto-play');
        if ('undefined' !== typeof originalImageTargetHeight) {
          gallery.setAttribute('data-image-target-height', originalImageTargetHeight);
        } else {
          gallery.removeAttribute('data-image-target-height');
        }
        if ('undefined' !== typeof originalAutoPlay) {
          gallery.setAttribute('data-auto-play', originalAutoPlay);
        } else {
          gallery.removeAttribute('data-auto-play');
        }
      });
    },
    removeThemes = function() {
      // Gallery
      galleries.forEach(function(gallery) {
        Array.prototype.forEach.call(gallery.classList, function(klass) {
          if (isClassTheme(klass)) {
            gallery.classList.remove(klass);
          }
        });
      });
      // Carousel
      carousels.forEach(function(carousel) {
        Array.prototype.forEach.call(carousel.classList, function(klass) {
          if (isClassTheme(klass)) {
            carousel.classList.remove(klass);
          }
        });
      });
      // Cell
      cells.forEach(function(cell) {
        Array.prototype.forEach.call(cell.classList, function(klass) {
          if (isClassTheme(klass)) {
            cell.classList.remove(klass);
          }
        });
      });
    },
    addClasses = function() {
      // Gallery
      galleries.forEach(function(gallery) {
        gallery.classList.add(classTheme());
      });
      // Carousel
      carousels.forEach(function(carousel) {
        carousel.classList.add(classTheme());
      });
      // Cell
      cells.forEach(function(cell) {
        cell.classList.add(classTheme());
        if (titleClassesContains('visible')) {
          cell.classList.add('is-title-visible');
        }
        if (descriptionClassesContains('visible')) {
          cell.classList.add('is-description-visible');
        }
      });
    },
    addAttributes = function() {
      var autoPlay = imageIndexValue('auto-play'),
        imageTargetHeight = photoValue('height');

      if ('undefined' !== typeof autoPlay) {
        galleries.forEach(function(gallery) {
          gallery.setAttribute('data-auto-play', autoPlay);
        });
      }

      if ('undefined' !== typeof imageTargetHeight) {
        galleries.forEach(function(gallery) {
          gallery.setAttribute('data-image-target-height', imageTargetHeight);
        });
      }
    },
    applyOptions = function() {
      window.ImageIndexSlider.destroyFlickityCarousels();

      restoreOriginalClasses();
      removeThemes();
      restoreOriginalAttributes();

      addClasses();
      addAttributes();

      // Style tag
      // window.ImageIndexSlider.setImageDimensionsStyle();
      setStyleTag();

      window.ImageIndexSlider.createFlickityCarousels();
    },
    setStyleTag = function() {
      var styleTag = document.getElementById('style-tag-options'),
        dbs = [],
        imageIndexBackgroundColor = imageIndexValue('background-color'),
        photoBackgroundColor = photoValue('background-color'),
        captionBackgroundColor = photoValue('caption-background-color'),
        titleColor = titleValue('color'),
        titleSize = titleValue('size'),
        descriptionColor = descriptionValue('color'),
        descriptionSize = descriptionValue('size');

      if ('undefined' !== typeof imageIndexBackgroundColor) {
        dbs.push('.iis-Gallery {');
        dbs.push('background-color: ' + hexToRgba(imageIndexBackgroundColor) + ' !important;');
        dbs.push('}');
      }

      if ('undefined' !== typeof photoBackgroundColor) {
        dbs.push('.iis-Cell {');
        dbs.push('background-color: ' + hexToRgba(photoBackgroundColor) + ' !important;');
        dbs.push('}');
      }

      if ('undefined' !== typeof captionBackgroundColor) {
        dbs.push('.iis-Cell-caption {');
        dbs.push('background-color: ' + hexToRgba(captionBackgroundColor) + ' !important;');
        dbs.push('}');
      }

      if ('undefined' !== typeof titleColor) {
        dbs.push('.iis-Cell-title {');
        dbs.push('color: ' + hexToRgba(titleColor) + ' !important;');
        dbs.push('}');
      }

      if ('undefined' !== typeof titleSize) {
        dbs.push('.iis-Cell-description {');
        dbs.push('font-size: ' + titleSize + 'px !important;');
        dbs.push('}');
      }

      if ('undefined' !== typeof descriptionColor) {
        dbs.push('.iis-Cell-description {');
        dbs.push('color: ' + hexToRgba(descriptionColor) + ' !important;');
        dbs.push('}');
      }

      if ('undefined' !== typeof descriptionSize) {
        dbs.push('.iis-Cell-description {');
        dbs.push('font-size: ' + descriptionSize + 'px !important;');
        dbs.push('}');
      }

      styleTag.innerHTML = dbs.join('\n');
    },
    imageIndexClassesContains = function(klass) {
      var classes = document.getElementById('classes-image-index').value;
      return -1 < classes.split(/\s+/).indexOf(klass);
    },
    photoClassesContains = function(klass) {
      var classes = document.getElementById('classes-photo').value;
      return -1 < classes.split(/\s+/).indexOf(klass);
    },
    titleClassesContains = function(klass) {
      var classes = document.getElementById('classes-title').value;
      return -1 < classes.split(/\s+/).indexOf(klass);
    },
    descriptionClassesContains = function(klass) {
      var classes = document.getElementById('classes-description').value;
      return -1 < classes.split(/\s+/).indexOf(klass);
    },
    imageIndexValue = function(key) {
      var classes = document.getElementById('classes-image-index').value;
      return extractValueFromClasses(classes, key);
    },
    photoValue = function(key) {
      var classes = document.getElementById('classes-photo').value;
      return extractValueFromClasses(classes, key);
    },
    titleValue = function(key) {
      var classes = document.getElementById('classes-title').value;
      return extractValueFromClasses(classes, key);
    },
    descriptionValue = function(key) {
      var classes = document.getElementById('classes-description').value;
      return extractValueFromClasses(classes, key);
    },
    extractValueFromClasses = function(classes, key) {
      var value;
      if (! classes.split) {
        return;
      }
      classes.split(/\s+/).forEach(function(klass) {
        if (0 === klass.indexOf(key + '-')) {
          value = klass.replace(key + '-', '');
        }
      });
      return value;
    },
    classesContains = function(classes, klass) {
      return -1 < classes.split(/\s+/).indexOf(klass);
    },
    isClassTheme = function(klass) {
      return klass && klass.indexOf && -1 < klass.indexOf('theme-');
    },
    classTheme = function() {
      var themeName = imageIndexValue('theme') || 'default';
      return 'theme-' + themeName;
    },
    hexToRgba = function(hex) {

      var r,
        g,
        b,
        a;

      hex = hex.replace('#', '');

      if (3 === hex.length) {
        r = hex.charAt(0);
        g = hex.charAt(1);
        b = hex.charAt(2);
      } else if (4 === hex.length) {
        r = hex.charAt(0);
        g = hex.charAt(1);
        b = hex.charAt(2);
        a = hex.charAt(3);
      } else if (6 === hex.length) {
        r = hex.substring(0, 2);
        g = hex.substring(2, 4);
        b = hex.substring(4, 6);
      } else if (8 === hex.length) {
        r = hex.substring(0, 2);
        g = hex.substring(2, 4);
        b = hex.substring(4, 6);
        a = hex.substring(6, 8);
      } else {
        return '';
      }

      if ('undefined' === typeof a) {
        a = 'ff';
      }

      if (1 === r.length) {
        r += r;
      }
      if (1 === g.length) {
        g += g;
      }
      if (1 === b.length) {
        b += b;
      }
      if (1 === a.length) {
        a += a;
      }

      r = parseInt(r, 16);
      g = parseInt(g, 16);
      b = parseInt(b, 16);
      a = parseInt(a, 16) / 255;

      return 'rgba(' + r + ',' + g + ',' + b + ',' + a + ')';

    };

  document.addEventListener('DOMContentLoaded', onDOMContentLoaded);
})();

// (function() {
//
//   /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
//    ██████  ██████  ██       ██████  ██████
//   ██      ██    ██ ██      ██    ██ ██   ██
//   ██      ██    ██ ██      ██    ██ ██████
//   ██      ██    ██ ██      ██    ██ ██   ██
//    ██████  ██████  ███████  ██████  ██   ██
//
//  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
//
//   var Color = function() {
//
//   };
//
//   /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
//   ███████ ██      ███████ ███    ███ ███████ ███    ██ ████████      ██████  ██████  ███    ███ ██████   ██████  ███    ██ ███████ ███    ██ ████████      ██████ ██       █████  ███████ ███████ ███████ ███████
//   ██      ██      ██      ████  ████ ██      ████   ██    ██        ██      ██    ██ ████  ████ ██   ██ ██    ██ ████   ██ ██      ████   ██    ██        ██      ██      ██   ██ ██      ██      ██      ██
//   █████   ██      █████   ██ ████ ██ █████   ██ ██  ██    ██        ██      ██    ██ ██ ████ ██ ██████  ██    ██ ██ ██  ██ █████   ██ ██  ██    ██        ██      ██      ███████ ███████ ███████ █████   ███████
//   ██      ██      ██      ██  ██  ██ ██      ██  ██ ██    ██        ██      ██    ██ ██  ██  ██ ██      ██    ██ ██  ██ ██ ██      ██  ██ ██    ██        ██      ██      ██   ██      ██      ██ ██           ██
//   ███████ ███████ ███████ ██      ██ ███████ ██   ████    ██         ██████  ██████  ██      ██ ██       ██████  ██   ████ ███████ ██   ████    ██         ██████ ███████ ██   ██ ███████ ███████ ███████ ███████
//
//   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
//
//   var ElementComponentClasses = function() {
//
//   }
// })();
