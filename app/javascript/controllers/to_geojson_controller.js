import { Controller } from "@hotwired/stimulus"
import toGeoJSON from "@mapbox/togeojson"
// import { DOMParser } from "@xmldom/xmldom"

// Connects to data-controller="to-geojson"
export default class extends Controller {
  static targets = ['labelGeoJson', 'inputFile', 'inputGeoJson', 'preTag']

  connect() {
    // console.log(this)

  }

  objectURL(file) {
    return window.URL.createObjectURL(file);
  }
  convert(event) {
    const file = this.inputFileTarget.files[0]
    if(file) {
      // console.log(file);
      // const fr = new FileReader()
      fetch(this.objectURL(file))
        .then(response => response.blob())
        .then((blob) => {
          // const kml = new File([blob], file.name, { type: "kml" })
          // console.log(kml)
          const reader = new FileReader()
          reader.onload = (event) => {
            this.#parseKmlToGeoJson(event)
          }
          reader.readAsText(blob, 'utf-8')
          // atualizar o input file value
          // this.
        })
    } else {
      // console.log(event.currentTarget);
      // console.log(event.currentTarget.files);
    }
  }

  adjustTextareaHeight(textarea) {
    textarea.style.height = 'auto';
    textarea.style.height = `${textarea.scrollHeight}px`;
  };

  #parseKmlToGeoJson(event) {
    // console.log(this)
    // console.log(this.inputGeoJsonTarget)

    const kmlContent = event.target.result
    const kml = new DOMParser().parseFromString(kmlContent, 'text/xml');
    if (kml.documentElement.nodeName === 'parsererror') {
      console.error('Erro ao analisar o documento XML.');
      return;
    }
    const convertedWithStyles = toGeoJSON.kml(kml, { styles: true });
    // console.log(convertedWithStyles)
    convertedWithStyles.features.filter(feature => feature.geometry.type === 'Point').forEach(feature => feature.properties.icon = `https${feature.properties.icon.substring(4)}`)
    // console.log("AFTER")
    // console.log(convertedWithStyles)
    this.inputGeoJsonTarget.innerText = JSON.stringify(convertedWithStyles)
    // this.adjustTextareaHeight(this.inputGeoJsonTarget)
    this.preTagTarget.innerText = JSON.stringify(convertedWithStyles, '', 2)
    // this.adjustTextareaHeight(this.preTagTarget)
    this.preTagTarget.style.maxHeight = '200px'
    this.labelGeoJsonTarget.hidden = false
  }
}
