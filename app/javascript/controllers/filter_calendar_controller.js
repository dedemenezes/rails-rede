import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-calendar"
export default class extends Controller {
  static targets = ['input', 'form', 'results', 'observatoryInput']
  connect() {

  }

  formToggle() {
    this.formTarget.classList.toggle('d-none')
    setTimeout(() => {
      this.formTarget.classList.toggle('box--hidden')
      if (this.formTarget.classList.contains('d-none')) {
        this.inputTarget._flatpickr.close()
      } else {
        this.inputTarget._flatpickr.open()
      }
    }, 150)
  }

  search(e) {
    e.preventDefault()
    const observatory = this.hasObservatoryInputTarget ? this.observatoryInputTarget.value : ''
    const observatoryFilter = `&observatory=${observatory}`
    this.url = `${this.formTarget.action}?before_date=${this.inputTarget.value}${observatoryFilter}`
    fetch(this.url, {
      headers: { 'Accept': 'text/plain' }
    })
      .then(response => response.text())
      .then((data) => {
        this.resultsTarget.outerHTML = data
      })
  }
}
