import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photo-preview"
export default class extends Controller {
  static targets = ['previewBox', 'photoInput', 'photoPreview', 'submit']
  connect() {
  }

  displayFilesCounter() {
    if (this.photoInputTarget.files.length > 0) {
      this.photoPreviewTarget.style.borderColor = '#083461'
      if (this.submitTarget) {
        this.submitTarget.classList.add('btn__album--active')
      }
      this.photoPreviewTarget.innerText = `${this.photoInputTarget.files.length} file${this.photoInputTarget.files.length > 1 ? 's' : ''} selected`
    }
  }

  displayPreview(event) {
    if (this.photoInputTarget.files && this.photoInputTarget.files[0]) {
      const reader = new FileReader();
      reader.onload = (event) => {
        this.previewBoxTarget.src = event.currentTarget.result;
      }
      reader.readAsDataURL(this.photoInputTarget.files[0])
      this.previewBoxTarget.classList.remove('d-none');
      this.previewBoxTarget.parentElement.classList.remove('d-none');
    }
  }
}
