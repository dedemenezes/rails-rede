import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-element"
export default class extends Controller {
  static targets = ['photoInput', 'docInput']
  connect() {
  }

  photoInput(){
    this.photoInputTarget.classList.toggle('d-none')
  }

  docInput(){
    this.docInputTarget.classList.toggle('d-none')

  }
}
