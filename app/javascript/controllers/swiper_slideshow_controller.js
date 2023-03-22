import { Controller } from "@hotwired/stimulus"
import Swiper, { Navigation, Pagination, Scrollbar, Autoplay, EffectFade } from 'swiper';

// Connects to data-controller="swiper-slideshow"
export default class extends Controller {
  connect() {
    console.log('hllo swiper slide');
    this.swiper = new Swiper(this.element, {
      modules: [Autoplay, EffectFade, Pagination],
      pagination: {
        el: '.swiper-pagination',
        type: 'bullets',
        clickable: true,
      },
      autoplay: {
        delay: 5000,
      },
      effect: 'fade',
      fadeEffect: {
        crossFade: true
      },
    })
  }
}
