import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photo-preview"
export default class extends Controller {
  static targets = ['photoInput', 'photoPreview', 'submit']
  connect() {
    // console.log(this.photoInputTarget);
    // console.log(this.photoPreviewTarget);
  }

  displayFilesCounter() {
    // console.log(this.photoInputTarget.files);
    // console.log(this.photoPreviewTarget);
    if (this.photoInputTarget.files.length > 0) {
      this.photoPreviewTarget.style.borderColor = '#083461'
      this.photoPreviewTarget.style.boxShadow = '4px 4px 20px rgba(0, 0, 0, .1)'
      if (this.submitTarget) {
        this.submitTarget.classList.add('btn__album--active')
      }
      this.photoPreviewTarget.innerText = `${this.photoInputTarget.files.length} file${this.photoInputTarget.files.length > 1 ? 's' : ''} selected`
    }
  }

  displayPreview(event) {
    if (this.photoInputTarget.files && this.photoInputTarget.files[0]) {
      const reader = new FileReader();
      console.log(this.photoInputTarget.files)
      reader.onload = (event) => {
        // this.photoInputTarget.files.forEach((file) =>{})
        this.photoPreviewTarget.src = event.currentTarget.result;
      }
      reader.readAsDataURL(this.photoInputTarget.files[0])
      this.photoPreviewTarget.classList.remove('hidden');
    }
  }
}
