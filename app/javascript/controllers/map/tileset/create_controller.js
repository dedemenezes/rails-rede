import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"
import mbxClient from '@mapbox/mapbox-sdk'
import mbxStyles from '@mapbox/mapbox-sdk/services/styles'
import mbxTilesets from '@mapbox/mapbox-sdk/services/tilesets'


// Connects to data-controller="map--tileset--create"
export default class extends Controller {
  static targets = ['fileField', 'nameField', 'form']
  static values = {
    apiKey: String
  }

  connect() {

  }

  fileSelected() {
    // console.log(this.fileFieldTarget.files)
    const file = this.fileFieldTarget.files[0]
    if (file) {
      this.fileFieldTarget.classList.remove('is-invalid')
      this.fileFieldTarget.classList.add('is-valid')
    } else {
      this.fileFieldTarget.classList.remove('is-valid')
      this.fileFieldTarget.classList.add('is-invalid')
    }
  }

  upload(event){
    event.preventDefault()

    // 1. pegar o arquivo do form

    const file = this.fileFieldTarget.files[0]
    if (file) {
      fetch(this.formTarget.action, {
        method: 'POST',
        body: new FormData(this.formTarget)
      })
        .then(response => response.json())
        .then((data) => {
          // console.log(data)
        })
    } else {
      Swal.fire(
        'Ops!',
        'Please choose a file',
        'warning'
      )
    }
  }
}
