import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-on-change"
export default class extends Controller {
  static targets = ['category', 'video', 'photo', 'document']
  connect() {
    const elements = ['video', 'photo', 'document'].map(e => this[`${e}Target`])
    console.log(elements);

    console.log(this.categoryTarget);
    console.log(this.categoryTarget.value);
    console.log(this[`${this.categoryTarget.value}Target`]);
    this.dynamicTarget(this.categoryTarget.value).classList.remove('d-none')
  }

  update(event) {
    ['video', 'photo', 'document'].forEach((name) => {
      this.dynamicTarget(name).classList.add('d-none')
    })
    const selected = event.currentTarget.value
    if (selected !== '') {
      this.dynamicTarget(selected).classList.remove('d-none')
    }
  }

  dynamicTarget(name) {
    return this[`${name}Target`]
  }
}
