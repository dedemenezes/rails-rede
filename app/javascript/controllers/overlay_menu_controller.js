import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="overlay-menu"
export default class extends Controller {
  static targets = ['menu', 'btn']
  connect() {
  }

  toggle() {
    this.menuTarget.classList.toggle('active')
    this.menuTarget.classList.toggle('overlay__content--active')
  }

  hide(event) {
    this.menuTarget.classList.remove('active')
  }
}
