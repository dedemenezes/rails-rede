import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fullscreen-element"
export default class extends Controller {
  static targets = ['mapContainer', 'button']
  static values = {
    maximizeIcon: String,
    minimizeIcon: String
  }
  connect() {
  }

  toggle() {
    if (!document.fullscreenElement) {
      this.mapContainerTarget.requestFullscreen();
      this.buttonTarget.innerHTML = `<i class="fa-solid fa-${this.minimizeIconValue}"></i>`
    } else if (document.fullscreenElement) {
      document.exitFullscreen();
      this.buttonTarget.innerHTML = `<i class="fa-solid fa-${this.maximizeIconValue}"></i>`
    }
  }
}
