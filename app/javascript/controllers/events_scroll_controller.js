import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="events-scroll"
export default class extends Controller {
  connect() {
  }

  toggleScroll() {
    // console.log(this.element);
    // this.element.classList.add('styled-scrollbars--active')
  }
}
