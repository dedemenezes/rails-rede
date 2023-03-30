import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-calendar"
export default class extends Controller {
  static targets = ['input', 'form', 'results']
  connect() {
  }

  formDisplay() {
    this.formTarget.classList.remove('d-none')
    setTimeout(() => {
      this.formTarget.classList.remove('box--hidden')
      this.inputTarget._flatpickr.open()
    }, 150)
  }

  search(e) {
    e.preventDefault()
    console.log(this.inputTarget);
    console.log();
    this.url = `${this.formTarget.action}?before_date=${this.inputTarget.value}`
    fetch(this.url, {
      headers: { 'Accept': 'text/plain' }
    })
      .then(response => response.text())
      .then((data) => {
        this.resultsTarget.outerHTML = data
      })
  }
}
