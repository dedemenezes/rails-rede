import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"
import mbxClient from '@mapbox/mapbox-sdk'
import mbxStyles from '@mapbox/mapbox-sdk/services/styles'
import mbxTilesets from '@mapbox/mapbox-sdk/services/tilesets'


// Connects to data-controller="map--tileset--create"
export default class extends Controller {
  static targets = ['fileField', 'nameField']
  static values = {
    apiKey: String
  }

  connect() {
    // fetch(`https://api.mapbox.com/uploads/v1/dedemenezes/credentials?access_token=${this.apiKeyValue}`, {
    //   method: 'POST'
    // })
    //   .then(response => { console.log(response.body) })

    this.baseClient = mbxClient({ accessToken: this.apiKeyValue })
    this.stylesService = mbxStyles(this.baseClient)
    this.tilesetsService = mbxTilesets(this.baseClient)
    console.log(this.baseClient)
    console.log(this.tilesetsService)



  }

  fileSelected() {
    console.log(this.fileFieldTarget.files)
    this.tilesetsService.createTilesetSource({
      id: `${this.sourceValue}_id`,
      // The string filename value works in Node.
      // In the browser, provide a Blob.
      file: this.fileFieldTarget.files[0]
    })
      .send()
      .then(response => {
        const tilesetSource = response.body;
        console.log(tilesetSource);
      });
      debugger
  }

  upload(event){
    event.preventDefault()
    const formData = new FormData()
    formData.append('tileset-file', this.fileFieldTarget.files[0])
    if(this.fileFieldTarget.length >= 1) {
      console.log('bota arquivo no form')
    }

    console.log(formData)

    const config = {
      method: 'POST',
      headers: {
        'Content-Type': 'multipart/form-data'
      },
      body: formData
    }
    fetch(
      `https://api.mapbox.com/tilesets/v1/sources/dedemenezes/${this.nameFieldTarget.value}?access_token=${this.apiKeyValue}`,
      config
    )
      .then((response) => {
        if(response.status === 200) {
          console.log(`success:`)
          console.log(response)
        } else {
          console.log('error')
          console.log(response)
        }
      })
  }
}
// POST "https://api.mapbox.com/tilesets/v1/sources/dedemenezes/hello-world?access_token=YOUR_MAPBOX_ACCESS_TOKEN" \
// -F file = @/Users/username / data / mts / countries.geojson.ld \
// --header "Content-Type: multipart/form-data"

// async function upload(formData) {
//   try {
//     const response = await fetch("https://example.com/profile/avatar", {
//       method: "PUT",
//       body: formData,
//     })
//     const result = await response.json()
//     console.log("Success:", result)
//   } catch (error) {
//     console.error("Error:", error)
//   }
// }

// const formData = new FormData()
// const fileField = document.querySelector('input[type="file"]')

// formData.append("username", "abc123")
// formData.append("avatar", fileField.files[0])

// upload(formData)
