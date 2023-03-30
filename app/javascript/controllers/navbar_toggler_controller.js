import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar-toggler"
export default class extends Controller {
  static targets = ['menu', 'menuList', 'socialLinks']

  connect() {
  }

  toggle(event) {
    this.menuTarget.classList.toggle('show')
    this.menuListTarget.classList.toggle('mx-auto')
    this.menuListTarget.classList.toggle('flex-grow-1')
    this.menuListTarget.classList.toggle('justify-content-center')
    this.menuListTarget.classList.toggle('navbar-mobile-font')
    this.element.classList.toggle('block-scroll')
    this.socialLinksTarget.classList.toggle('w-100')
    this.socialLinksTarget.classList.toggle('mb-3')
    this.socialLinksTarget.classList.toggle('d-flex')
    this.socialLinksTarget.classList.toggle('justify-content-center')

    if (this.menuTarget.classList.contains('show')) {
      event.currentTarget.innerHTML = '<i class="fas fa-times"></i>'
    } else {
      event.currentTarget.innerHTML = "<i class='fas fa-bars'></i>"
    }
  }
}
