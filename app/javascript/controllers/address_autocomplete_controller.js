import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ['municipality', 'streetWrapper', "street", "number", 'neighborhood', 'city', 'state', 'zip_code', 'latitude', 'longitude']

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address"
    })
    console.log(this.geocoder);
    console.log(this.streetTarget);
    this.geocoder.addTo(this.streetWrapperTarget)
    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())
  }

  #setInputValue(event) {
    console.log(event);
    event.result.context.forEach((el) => {
      if (el.id.match(/place/)) {
        this.cityTarget.value = el.text
      }
      if (el.id.match(/neighborhood/) || el.id.match(/(locality)/)) {
        this.neighborhoodTarget.value = el.text
      }
      if (el.id.match(/region/)) {
        this.stateTarget.value = el.text
        this.municipalityTarget.value = el.short_code.split('-')[1]
      }
      if (el.id.match(/postcode/)) {
        this.zip_codeTarget.value = el.text
      }
    })
    if (event.result["address"]) {
      this.numberTarget.value = event.result["address"]
    }
    this.streetTarget.value = event.result["place_name"]
    this.longitudeTarget.value = event.result.geometry.coordinates[0]
    this.latitudeTarget.value = event.result.geometry.coordinates[1]
  }

  #clearInputValue() {
    this.streetTarget.value = ""
    this.cityTarget.value = ""
    this.neighborhoodTarget.value = ""
    this.municipalityTarget.value = ""
    this.zip_codeTarget.value = ""
    this.numberTarget.value = ""
    this.streetTarget.value = ""
    this.longitudeTarget.value = ""
    this.latitudeTarget.value = ""
  }

  disconnect() {
    this.geocoder.onRemove()
  }
}
