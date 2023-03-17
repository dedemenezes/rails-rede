import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-button-on-hover"
export default class extends Controller {
  connect() {
  }

  display() {
    console.log('in!');
    this.element.classList.add('visiblee')
  }

  hide() {
    console.log('out!');
    this.element.classList.remove('visiblee')
  }
}
