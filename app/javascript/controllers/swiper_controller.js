import { Controller } from "@hotwired/stimulus"
import Swiper from 'swiper';

// Connects to data-controller="swiper"
export default class extends Controller {
  connect() {
    console.log(`Hi, ${this.element}`)
    this.swiper = new Swiper(this.element, {
      slidesPerView: 3,
      spaceBetween: 2,
      centeredSlides: false,
      pagination: {
        el: ".swiper-pagination",
        clickable: true,
      },
    })
  }
}
