import { Controller } from "@hotwired/stimulus"
import Swiper, { Navigation, Autoplay } from "swiper"

export default class extends Controller {
  static values = {
    spaceBetween: Number
    ,slidesPerView: Number
    ,slidesPerView: Number
    ,slidesPerViewSm: Number
    ,slidesPerViewMd: Number
    ,slidesPerViewLg: Number
    ,slidesPerViewXl: Number
    ,slidesPerViewXxl: Number
  }

  connect() {
    console.log("SwiperCollaboratorsController");

    new Swiper(this.element, {
      modules: [Navigation, Autoplay],
      slidesPerView: this.slidesPerViewValue,
      spaceBetween: this.spaceBetweenValue,
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
      // Responsive breakpoints
      breakpoints: {
      //   // when window width is >= 576px
      //   320: {
      //     slidesPerView: this.slidesPerViewValue,
      //     centeredSlides: true,
      //   },
      //   // when window width is >= 576px
        576: {
          slidesPerView: this.slidesPerViewSmValue,
        },
      //   // when window width is >= 768px
        768: {
        slidesPerView: this.slidesPerViewMdValue,
        },
        // when window width is >= 992px
        992: {
          slidesPerView: this.slidesPerViewLgValue,
        },
        // when window width is >= 1200px
        1200: {
          slidesPerView: this.slidesPerViewXlValue,
        },
        // when window width is >= 1400px
        1400: {
          slidesPerView: this.slidesPerViewXxlValue,
        }
      }
    })

  }
}
