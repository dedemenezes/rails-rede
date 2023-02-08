import { Controller } from "@hotwired/stimulus"
import Swiper from 'swiper';

// Connects to data-controller="swiper"
export default class extends Controller {
  static targets = ['wrapper']

  connect() {
    console.log(this.wrapperTarget)
    this.swiper = new Swiper(this.element, {
      slidesPerView: 3,
      spaceBetween: 2,
      centeredSlides: false,
      pagination: {
        el: ".swiper-pagination",
        clickable: true,
      },
    })
    this.swiper.on('slideChange', (event) => {
      console.log(this.wrapperTarget.classList.contains('container'))
      if (this.wrapperTarget.classList.contains('container')) {
        this.wrapperTarget.classList.remove('container')
      }
    })
  }
}
