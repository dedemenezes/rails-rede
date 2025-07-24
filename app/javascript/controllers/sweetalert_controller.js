import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="sweetalert"
export default class extends Controller {
  static targets = ["checkboxInput"]

  static values = {
    icon: String,
    title: String,
    html: String,
    confirmButtonText: String,
    showCancelButton: Boolean,
    cancelButtonText: String
    ,confirmButtonColor: String
    ,cancelButtonColor: String
    ,featured: Boolean
    ,isFeatured: Boolean
    ,alertText: String
  }
  connect() {
    console.log(this.featuredValue)
    this.swalWithBootstrapButtons = Swal.mixin({
      customClass: {
        confirmButton: "btn btn-primary me-4 btn--sweetalert",
        cancelButton: "btn btn-danger btn--sweetalert"
      },
      buttonsStyling: false
    });
    this.swalOptions = {
      title: "Confirmar?",
      text: this.alertTextValue,
      icon: "warning",
      showCancelButton: this.showCancelButtonValue,
      confirmButtonText: this.confirmButtonTextValue,
      cancelButtonText: this.cancelButtonTextValue,
    }
    this.updateFeaturedEvent = "updateFeatured"
  }

  confirmFeatured(event) {
    console.log("eventCurrentTarget: " + event.currentTarget)
    if (this.#isRemovingFeatured()) {
      this.swalWithBootstrapButtons
        .fire(this.swalOptions)
        .then(result => this.#handleUserConfirmation(result))
    } else if (this.#isOverwritingFeatured()) {
      this.swalWithBootstrapButtons
        .fire(this.swalOptions)
        .then(result => this.#handleUserConfirmation(result))
    } else {
      this.dispatch(this.updateFeaturedEvent)
    }
  }

  #isRemovingFeatured() {
    return this.isFeaturedValue && !this.checkboxInputTarget.checked
  }

  #isOverwritingFeatured() {
    return !this.isFeaturedValue && this.featuredValue && this.checkboxInputTarget.checked
  }

  #handleUserConfirmation(result) {
    if (result.isConfirmed) {
      this.dispatch(this.updateFeaturedEvent)
    } else if (result.dismiss === Swal.DismissReason.cancel) {
      this.checkboxInputTarget.checked = !this.checkboxInputTarget.checked
    }
  }

  initSweetalert(event) {
    event.preventDefault() // Prevent the form to be submited after the submit button has been clicked
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
          event.target[event.type]() // "submit"
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
