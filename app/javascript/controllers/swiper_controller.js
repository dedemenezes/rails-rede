import { Controller } from "@hotwired/stimulus"
import Swiper, { Navigation, Pagination, Scrollbar } from 'swiper';

// Connects to data-controller="swiper"
export default class extends Controller {
  static targets = ['wrapper']
  static values = {
    slidesPerView: Number
  }

  connect() {
    // console.log(this.wrapperTarget)
    this.swiper = new Swiper(this.element, {
      modules: [Navigation, Pagination, Scrollbar],
      centeredSlides: true,
      pagination: {
        el: '.swiper-pagination',
        type: 'bullets',
        clickable: true,
      },

      breakpoints: {
        // when window width is >= 320px
        300: {
          centeredSlides: false,
          slidesPerView: 1,
          spaceBetween: 10,
        },
        // when window width is >= 768
        768: {
          slidesPerView: 2,
          centeredSlides: false,
          spaceBetween: 20,

        },
        1200: {
          slidesPerView: 3,
          centeredSlides: false,
          // spaceBetween: 10,
          spaceBetween: 30,
          grabCursor: true,

        },
      },
    })
    // this.swiper.on('slideChange', (event) => {
    //   if (this.wrapperTarget.classList.contains('container')) {
    //     this.wrapperTarget.classList.remove('container')
    //   }
    // })
    // this.swiper.on('doubleTap', (event) => {
    //   console.log('DOIS CLICKS');
    //   this.swiper.navigation.nextEl
    // })
    // this.swiper.on('doubleClick', (event) => {
    //   // console.log(event);
    //   if (event.touches.currentX < window.innerWidth / 2) {
    //     this.swiper.slidePrev()
    //   } else{
    //     this.swiper.slideNext()
    //   }
    // })
  }
}
