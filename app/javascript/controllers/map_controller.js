import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'



// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    tilesets: Array,
    style: String,
  }

  static targets = ['mapContainer', 'menuOption', 'listingGroup', "cover"]

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.mapContainerTarget,
      style: this.styleValue
    })

    this.map.dragPan.disable()
    this.map.scrollZoom.disable()

    if (this.markersValue.length !== 0) {
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
    }
    this.#addNavigationtoMap()
    this.#addListenersToMeniuOptions()

    // this.macae = Array.from(this.tilesetsValue)
    //                   .find(tileset => tileset.sourceValue === 'Cabo_Frio')
    // console.log(this.macae)
    // const macaeGeoJson = JSON.parse(this.macae.geoJson)
    // const pointFeatures = macaeGeoJson.features.filter(feature => feature.geometry.type == 'Point')
    // const polygonFeatures = macaeGeoJson.features.filter(feature => feature.geometry.type == 'Polygon')
    // console.log(pointFeatures)
    // console.log(polygonFeatures)




    this.map.on('load', (e) => {
      this.map.addSource('my-data', {
        type: 'vector',
        url: 'mapbox://dedemenezes.saofranciscodeitabapoana_final'
      });
      this.map.addLayer({
        'id': 'my-data-points',
        'type': 'circle',
        'source': 'my-data',
        'source-layer': 'inspections-points',
        'paint': {
          'circle-radius': 4,
          'circle-color': '#ff69b4'
        }
      });



      // OLD

      // this.map.addSource(this.macae.sourceValue, {
      //   'type': 'geojson',
      //   'data': macaeGeoJson
      // })
      // polygonFeatures.forEach((feature, index) => {
      //   const featureSourceId = this.setFeatureSourceId(this.macae.sourceValue, feature, index)

      //   this.map.addSource(featureSourceId, {
      //     'type': 'geojson',
      //     'data': feature
      //   })

      //   const layerId = featureSourceId + '-fill'

      //   this.map.addLayer({
      //     'id': layerId,
      //     'type': 'fill',
      //     'source': featureSourceId,
      //     'layout': {
      //       // Make the layer visible by default.
      //       'visibility': 'visible'
      //     },
      //     'paint': {
      //       'fill-antialias': true,
      //       'fill-color': feature.properties.fill,
      //       'fill-opacity': feature.properties["fill-opacity"],
      //     },
      //     'sourceLayer': `polygon-${feature.properties.fill}-layer`
      //   })
      //   this.map.addLayer(
      //     {
      //       id: layerId + '-label',
      //       // References the GeoJSON source defined above
      //       // and does not require a `source-layer`
      //       source: featureSourceId,
      //       type: 'symbol',
      //       layout: {
      //         // Set the label content to the
      //         // feature's `name` property
      //         'text-field': feature.properties.name,
      //       }
      //     },
      //   )

      //   this.addSourcePopupsOnHovering(layerId)
      // })

      // const featuresByIcons = Object.groupBy(pointFeatures, ({ properties }) => properties.icon)
      // // console.log(featuresByIcons)
      // Object.keys(featuresByIcons).forEach((icon) => {
      //   this.#loadImageAndAddToMap(this.map, icon, (imgName) => {
      //     featuresByIcons[icon].forEach((feature, index) => {
      //       this.#processFeatures(this.map, feature, imgName, index);
      //     });
      //   });
      // })
    })

  }

  setFeatureSourceId(sourceValue, feature, index) {
    const featureType = feature.geometry.type
    const featureStyleUrl = feature.properties.styleUrl
    return `${index + 1}_${sourceValue}-${featureType}${featureStyleUrl}`
  }

  addSourcePopupsOnHovering(layerId) {
    this.hoveredPolygonId = null
    this.popup = null
    // this.map.on('mousemove', this.sourceValue, (e) => {
    // if (e.features.length > 0) {
    //   if (this.hoveredPolygonId !== null) {
    //     this.map.setFeatureState(
    //       { source: this.sourceValue, sourceLayer: this.sourceValue, id: this.hoveredPolygonId },
    //       { hover: false }
    //     )
    //   }
    //   this.hoveredPolygonId = e.features[0].id
    //   this.map.setFeatureState(
    //     { source: this.sourceValue, sourceLayer: this.sourceValue, id: this.hoveredPolygonId },
    //     { hover: true }
    //   )
    //   this.addSourcePopup(e)
    // }
    // })

    // const layerId = tileset.sourceValue + '--fill'

    this.map.on('mouseenter', layerId, (e) => {
      this.addSourcePopup(e)
      // console.log('ENTROU!');
      // console.log(e);
      // console.log('SAINDO DO ENTROU Evento');
      // Single out the first found feature.
      const feature = e.features[0]
    })

    this.map.on('mouseleave', layerId, (e) => {
      // console.log('SAINDO ELEMENT | LEAVE Event')
      this.removeSourcePopup()
      // console.log('SAINDO DO LEAVE Event')
    })
  }

  removeSourcePopup() {
    if (this.popup.isOpen()) {
      this.popup.remove()
      this.popup = null
    }
    this.hoveredPolygonId = null
  }

  addSourcePopup(event) {

    // if (this.popup) {
    //   this.popup.remove()
    // }
    // create popup
    if (this.popup) {
      return undefined
    }

    let popHTML = `<p>`
    const properties = event.features[0].properties
    Object.entries(properties).forEach((k) => popHTML += `<strong>${k[0]}:</strong> ${k[1]}<br>`)
    popHTML += '</p>'

    this.popup = new mapboxgl.Popup().setHTML(popHTML)
    // Display a popup with the name of the county
    this.popup.setLngLat([event.lngLat.lng, event.lngLat.lat])
              .addTo(this.map)
      // .setText(feature.properties.Description)
  }

  coverWarning() {
    if (this.map.dragPan.isEnabled() || this.map.scrollZoom.isEnabled()) {
    } else {
      this.#displayCoverElement()
      this.#fadeOutCoverElement()
    }
  }

  #loadImageAndAddToMap(map, icon, callback) {
    const nameRegex = /.+\/(.+\w+)\.\w+$/
    const imgName = icon.match(nameRegex)[1]

    map.loadImage(icon, (error, image) => {
      if (error) throw error

      map.addImage(imgName, image);
      callback(imgName)
    })
  }

  #processFeatures(map, feature, imgName, index) {
    const featureSourceId = this.setFeatureSourceId(this.macae.sourceValue, feature, index)
    map.addSource(featureSourceId, {
      'type': 'geojson',
      'data': feature
    })
    this.map.addLayer(
      {
        id: featureSourceId + '-icon',
        // References the GeoJSON source defined above
        // and does not require a `source-layer`
        source: featureSourceId,
        type: 'symbol',
        layout: {
          // Set the label content to the
          // feature's `name` property
          'icon-image': imgName, // reference the image
          'icon-size': 0.25
        }
      },
    )
  }

  #fadeOutCoverElement() {
    setTimeout(() => {
      this.coverTarget.style.opacity = 0
    }, 3000)
    setTimeout(() => {
      this.coverTarget.style.zIndex = -5
    }, 3200)
  }

  #displayCoverElement() {
    this.coverTarget.style.opacity = 1
    this.coverTarget.style.zIndex = 5
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      const element = document.createElement('div')
      element.className = 'marker'
      element.style.backgroundImage = `url('${marker.image_url}')`
      element.style.backgroundSize = 'contain'
      element.style.width = '19px'
      element.style.height = '25px'
      new mapboxgl.Marker(element)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #addNavigationtoMap() {
    const nav = new mapboxgl.NavigationControl({
      showCompass: true,
      showZoom: true
    })
    this.map.addControl(nav, 'bottom-right')
  }

  #addListenersToMeniuOptions() {
    this.listingGroupTarget.addEventListener('change', (event) => {
      const option = event.target.id
      if (event.target.checked) {
        this.map[option].enable()
        this.coverTarget.style.opacity = 0
        this.coverTarget.style.zIndex = -5
      } else {
        this.map[option].disable()
      }
    })
  }
}
