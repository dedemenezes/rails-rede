import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-calendar"
export default class extends Controller {
  static targets = ['input', 'form', 'results']
  connect() {
    console.log(this.formTarget);
    console.log(this.inputTarget);
    console.log(this.resultsTarget);
  }

  formDisplay() {
    console.log(this.formTarget);
    console.log(this.inputTarget);
    console.log(this.resultsTarget);
    this.formTarget.classList.remove('d-none')
    setTimeout(() => {
      this.formTarget.classList.remove('box--hidden')
    }, 250)
  }
}
