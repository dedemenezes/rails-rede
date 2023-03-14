import { Controller } from "@hotwired/stimulus"
import Swiper from 'swiper';

// Connects to data-controller="swiper"
export default class extends Controller {
  static targets = ['wrapper']
  static values = {
    slidesPerView: Number
  }

  connect() {
    // console.log(this.wrapperTarget)
    this.swiper = new Swiper(this.element, {
      breakpoints: {
        // when window width is >= 320px
        320: {
          slidesPerView: 1,
          spaceBetween: 5
        },
        // when window width is >= 480px
        768: {
          slidesPerView: 2,
        },
        // when window width is >= 640px
        1024: {
          slidesPerView: 3,
        }
      },
      slideActiveClass: 'card__event--active'
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
    this.swiper.on('doubleClick', (event) => {
      // console.log(event);
      if (event.touches.currentX < window.innerWidth / 2) {
        this.swiper.slidePrev()
      } else{
        this.swiper.slideNext()
      }
    })
  }
}
