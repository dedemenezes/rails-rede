import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="overlay-menu"
export default class extends Controller {
  static targets = ['menu', 'btn', 'formContainer', 'form', 'input', 'inputWrapper']
  connect() {
  }

  toggle() {
    this.formContainerTarget.classList.toggle('active')
    this.inputWrapperTarget.classList.toggle('d-none')
    // this.formContainerTarget.classList.toggle('overlay__content--active')
  }

  hide(event) {
    this.formContainerTarget.classList.remove('active')
  }
}
