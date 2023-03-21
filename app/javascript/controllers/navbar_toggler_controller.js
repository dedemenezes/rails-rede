import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar-toggler"
export default class extends Controller {
  static targets = ['menu']

  connect() {
  }

  toggle() {
    this.menuTarget.classList.toggle('show')
    this.element.classList.toggle('block-scroll')
  }
}
