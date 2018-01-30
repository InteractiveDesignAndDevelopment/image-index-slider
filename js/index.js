import ImageIndexSlider from './image-index-slider.js';

document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.image-index-slider').forEach(el => {
    new ImageIndexSlider(el);
  });
});
