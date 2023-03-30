import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-photo-input"
export default class extends Controller {
  static targets = ['input', 'button', 'checkbox']
  connect() {
    this.displayInput()
  }

  display(event) {
    event.preventDefault()
    this.inputTarget.classList.add('box--show')
    this.inputTarget.classList.remove('box--hidden')
    this.buttonTarget.classList.add('d-none')
  }

  displayInput() {
    if (this.hasCheckboxTarget && this.checkboxTarget.checked) {
      this.inputTargets.forEach(target => target.classList.add('box--show'))
      this.inputTargets.forEach(target => target.classList.remove('box--hidden'))
    } else {
      this.inputTargets.forEach(target => target.classList.remove('box--show'))
      this.inputTargets.forEach(target => target.classList.add('box--hidden'))
    }
  }
}
