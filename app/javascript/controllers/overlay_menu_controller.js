import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="overlay-menu"
export default class extends Controller {
  static targets = ['menu', 'btn', 'formContainer', 'form', 'input']
  connect() {
  }

  toggle() {
    this.formContainerTarget.classList.toggle('active')
    if (!this.formContainerTarget.classList.includes('active')) {
      this.inputTarget.focus()
    }
    // this.formContainerTarget.classList.toggle('overlay__content--active')
  }

  hide(event) {
    this.formContainerTarget.classList.remove('active')
  }
}
