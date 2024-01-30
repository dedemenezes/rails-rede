import { Controller } from "@hotwired/stimulus"
import toGeoJSON from "@mapbox/togeojson"
// import { DOMParser } from "@xmldom/xmldom"

// Connects to data-controller="to-geojson"
export default class extends Controller {
  static targets = ['labelGeoJson', 'inputFile', 'inputGeoJson', 'preTag']

  connect() {

  }

  objectURL(file) {
    return window.URL.createObjectURL(file);
  }
  convert(event) {
    const file = this.inputFileTarget.files[0]
    if(file) {
      // const fr = new FileReader()
      fetch(this.objectURL(file))
        .then(response => response.blob())
        .then((blob) => {
          // const kml = new File([blob], file.name, { type: "kml" })
          const reader = new FileReader()
          reader.onload = (event) => {
            this.#parseKmlToGeoJson(event)
          }
          reader.readAsText(blob, 'utf-8')
          // atualizar o input file value
          // this.
        })
    } else {
    }
  }

  adjustTextareaHeight(textarea) {
    textarea.style.height = 'auto';
    textarea.style.height = `${textarea.scrollHeight}px`;
  };

  #parseKmlToGeoJson(event) {

    const kmlContent = event.target.result
    const kml = new DOMParser().parseFromString(kmlContent, 'text/xml');
    if (kml.documentElement.nodeName === 'parsererror') {
      return;
    }
    const convertedWithStyles = toGeoJSON.kml(kml, { styles: true });
    convertedWithStyles.features.filter(feature => feature.geometry.type === 'Point').forEach(feature => feature.properties.icon = `https${feature.properties.icon.substring(4)}`)

    kml.getElementsByTagName('MultiGeometry')[0].childNodes.forEach((geometryNode) => {

      // featureProperties = Object.assign({}, convertedWithStyles.features[featureIndex].properties)
      if (geometryNode.nodeType === 1) { // Check if it's an element node
        if (geometryNode.nodeName === 'MultiGeometry') {
          // Handle nested MultiGeometry, iterate through its child nodes
          geometryNode.childNodes.forEach((polygonNode) => {
            if (polygonNode.nodeName === 'Polygon') {
              // extract coordinates into array of array's
              const polygonCoordinates = this.findAndBuildCoordinates(polygonNode)

              // create GeoJson feature
              const feature = {
                type: 'Feature',
              }
              feature.geometry = {
                type: 'Polygon',
                coordinates: [polygonCoordinates]
              }

              const placemark = geometryNode.parentElement.parentElement
              // 1. NAME
              const name = placemark.querySelector('name')
              if (name) {
                const nameText = name.textContent
                const parentFeature = convertedWithStyles.features.find((element) => {
                  if (element.properties && element.properties.name) {
                    return element.properties['name'] === nameText
                  }
                })
                feature.properties = {
                  ...parentFeature.properties
                }
              }
              console.log(feature)

              convertedWithStyles.features.push(feature);
            }
          })
        }
      }
    })

    this.inputGeoJsonTarget.innerText = JSON.stringify(convertedWithStyles)
    // this.adjustTextareaHeight(this.inputGeoJsonTarget)
    this.preTagTarget.innerText = JSON.stringify(convertedWithStyles, '', 2)
    // this.adjustTextareaHeight(this.preTagTarget)
    this.preTagTarget.style.maxHeight = '200px'
    this.labelGeoJsonTarget.hidden = false
  }

  findAndBuildCoordinates(polygonNode) {
    const coordinatesArray = polygonNode.querySelector('coordinates').textContent.trim().split(' ')
    return coordinatesArray.map(this.extractCoordinates)
  }

  extractCoordinates(coordinates) {
    const [lng, lat, elevation] = coordinates.split(',').map(Number)
    return [lng, lat, elevation]
  }
}
