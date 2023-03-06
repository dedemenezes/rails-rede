import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="active-on-height"
export default class extends Controller {
  static targets = ['link', 'methodologies', 'project']

  connect() {
    this.setClass()
  }

  setClass() {
    if (this.methodologiesTarget.getBoundingClientRect().y < window.innerHeight) {
      const target = Array.from(this.linkTargets).find(e => e.innerText === 'Metodologias')
      this.linkTargets.forEach(e => e.classList.remove('active'))
      target.classList.add('active')
    } else if (this.projectTarget.getBoundingClientRect().y < window.innerHeight) {
      const target = Array.from(this.linkTargets).find(e => e.innerText === 'O Projeto')
      this.linkTargets.forEach(e => e.classList.remove('active'))
      target.classList.add('active')
    }
  }
}
