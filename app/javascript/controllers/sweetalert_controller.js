import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="sweetalert"
export default class extends Controller {
  static values = {
    icon: String,
    title: String,
    html: String,
    confirmButtonText: String,
    showCancelButton: Boolean,
    cancelButtonText: String
    ,featured: Boolean,
  }
  connect() {
  }

  confirmFeatured(event) {
    if (this.featuredValue) {
      Swal.fire().then((action) => {
        if (action.isConfirmed) {
          this.dispatch("updateFeatured", { detail: { content: "UPDATE ITTT!" } })
          // navigator.clipboard.writeText(this.sourceTarget.value)
        }
      })
    }
  }

  initSweetalert(event) {
    event.preventDefault(); // Prevent the form to be submited after the submit button has been clicked
    const options = {
      icon: this.iconValue,
      title: this.titleValue,
      html: this.htmlValue,
      confirmButtonText: this.confirmButtonTextValue,
      showCancelButton: this.showCancelButtonValue,
      cancelButtonText: this.cancelButtonTextValue,
      reverseButtons: true,
      showLoaderOnConfirm: true,
      preConfirm: (login) => {
        event.target[event.type]()
          .then(response => {
            if (!response.ok) {
              throw new Error(response.statusText)
            }
            return response.json()
          })
          .catch(error => {
            Swal.showValidationMessage(
              `Request failed: ${error}`
            )
          })
      }
    }
    Swal.fire(options)
      .then((action) => {
        if (action.isConfirmed) {
          event.target[event.type](); // "submit"
          Swal.fire(
            'Confirmado!',
            'Your file has been deleted.',
            'success'
          )
        }
      })
      .catch(event.preventDefault())
  }
}
