import { Controller } from "@hotwired/stimulus"
import toGeoJSON from "@mapbox/togeojson"
// import { DOMParser } from "@xmldom/xmldom"

// Connects to data-controller="to-geojson"
export default class extends Controller {
  static targets = ['progressBar','inputFile']

  objectURL(file) {
    return window.URL.createObjectURL(file);
  }
  convert() {
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
          console.log(reader)
          reader.onload = this.#parseKmlToGeoJson
          reader.readAsText(blob, 'utf-8')
          console.log('Flamengo deu mole');
          console.log(reader)

          // atualizar o input file value
          // this.
        })
    } else {
      console.log(event.currentTarget);
      console.log(event.currentTarget.files);
    }
  }

  #parseKmlToGeoJson(event) {
    const kmlContent = event.target.result
    const kml = new DOMParser().parseFromString(kmlContent, 'text/xml');
    if (kml.documentElement.nodeName === 'parsererror') {
      console.error('Erro ao analisar o documento XML.');
      return;
    }
    const converted = toGeoJSON.kml(kml);
    const convertedWithStyles = toGeoJSON.kml(kml, { styles: true });
    console.log(convertedWithStyles)


  }
}
