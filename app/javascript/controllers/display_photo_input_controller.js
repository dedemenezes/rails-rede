import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-photo-input"
export default class extends Controller {
  static targets = ['input', 'button']
  connect() {
    console.log(this.inputTarget);
  }

  display(event) {
    event.preventDefault()
    this.inputTarget.classList.add('box--show')
    this.inputTarget.classList.remove('box--hidden')
    this.buttonTarget.classList.add('d-none')
  }
}
