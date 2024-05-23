import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-on-change"
export default class extends Controller {
  static targets = ['video', 'photo', 'document']
  connect() {
    console.log(this);
    console.log(this.targets);
  }

  update(event) {
    ['video', 'photo', 'document'].forEach((name) => {
      this[`${name}Target`].classList.add('d-none')
    })
    const selected = event.currentTarget.value
    if (selected !== '') {
      this[`${selected}Target`].classList.remove('d-none')
    }
  }
}
