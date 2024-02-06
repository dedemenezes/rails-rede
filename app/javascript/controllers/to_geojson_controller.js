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


    // Assuming kml is the XML document obtained from parsing the KML file
    let placemarks = kml.getElementsByTagName('Placemark');

    for (let i = 0; i < placemarks.length; i++) {
      let placemark = placemarks[i];
      let multiGeometries = this.findNestedMultiGeometries(placemark);
      const polygonNodes = []
      multiGeometries.forEach((geometryNode) => {
        this.findPolygonNodes(geometryNode, polygonNodes)
      })

      if (polygonNodes.length !== 0) {
        polygonNodes.forEach((polygonNode) => {
          const polygonCoordinates = this.findAndBuildCoordinates(polygonNode)
          const feature = {
            type: 'Feature',
          }
          feature.geometry = {
            type: 'Polygon',
            coordinates: [polygonCoordinates]
          }

          const name = placemark.querySelector('name')
          if (name) {
            const parentFeature = convertedWithStyles.features.find((element) => {
              if (element.properties && element.properties.name) {
                return element.properties['name'] === name.textContent
              }
            })
            feature.properties = {...parentFeature.properties}
          }
          convertedWithStyles.features.push(feature);
        })
      }
    }

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

  findPolygonNodes(node, resultArray) {
    if (node.nodeName === 'Polygon' && this.nestedMoreThanOneLeve(node)) {
      resultArray.push(node)
    }

    if (node.nodeName === 'MultiGeometry') {
      for (let i = 0; i < node.childNodes.length; i++) {
        const childNode = node.childNodes[i]
        this.findPolygonNodes(childNode, resultArray)
      }
    }
  }

  nestedMoreThanOneLeve(node) {
    return node.parentNode.parentNode.nodeName !== 'Placemark'
  }

  findPlacemarkNode(node) {
    if (node.nodeName === 'Placemark') {
      return node
    }

    const parentNode = node.parentNode
    return this.findPlacemarkNode(parentNode)
  }


  // recursively search for MultiGeometry elements inside Placemark
  findNestedMultiGeometries(placemark) {
    let multiGeometries = [];

    let directMultiGeometries = Array.from(placemark.getElementsByTagName('MultiGeometry'));

    if (directMultiGeometries.length > 0) {
      directMultiGeometries.forEach(directMultiGeometry => {
        if (this.hasNestedMultiGeometry(directMultiGeometry)) {
          multiGeometries.push(directMultiGeometry);
        }
      });
    }

    return multiGeometries;
  }

  // to check if a MultiGeometry element has nested MultiGeometry elements
  hasNestedMultiGeometry(multiGeometry) {
    let nestedMultiGeometries = Array.from(multiGeometry.getElementsByTagName('MultiGeometry'));
    return nestedMultiGeometries.length > 0;
  }
}
