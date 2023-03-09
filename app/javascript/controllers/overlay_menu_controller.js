import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="overlay-menu"
export default class extends Controller {
  static targets = ['menu', 'btn', 'formContainer']
  connect() {
  }

  toggle() {
    this.formContainerTarget.classList.toggle('active')
    // this.formContainerTarget.classList.toggle('overlay__content--active')
  }

  hide(event) {
    this.formContainerTarget.classList.remove('active')
  }
}
