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
      style: this.styleValue,
      center: [-41.071818909425474, -21.408881455430915],
      zoom: 8
    })

    this.map.dragPan.disable()
    this.map.scrollZoom.disable()

    if (this.markersValue.length !== 0) {
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
    }
    this.#addNavigationtoMap()
    this.#addListenersToMeniuOptions()


    this.hoveredPolygonId = null
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
        "paint": {
          'circle-color': "rgb(255, 255, 0)",
        }
      });

      this.map.addLayer({
        'id': 'my-data-polygons',
        'type': 'fill',
        'source': "my-data",
        'source-layer': 'inspections-areas',
        'paint': {
          'fill-color': ['get', 'fill'],
          'fill-opacity': [
            'case',
            ['boolean', ['feature-state', 'hover'], false],
            0.7,
            0.5
          ],
        }
      });

      // this.map.addLayer({
      //   'id': 'my-data-polygons-labels',
      //   'type': 'symbol',
      //   'source': 'my-data',
      //   'source-layer': 'inspections-points',
      //   "paint": {
      //     'circle-color': "rgb(255, 255, 0)", // assuming 'icon' is the name of the property containing the icon URL
      //   }
      // })

      this.map.on('mouseenter', 'my-data-polygons', (event) => {
        this.map.getCanvas().style.cursor = 'pointer';
        if (event.features.length > 0) {
          if (this.hoveredPolygonId !== null) {
            this.map.setFeatureState(
              { source: 'my-data', sourceLayer: 'inspections-areas', id: this.hoveredPolygonId },
              { hover: false }
            );
          }
          this.hoveredPolygonId = event.features[0].id;
          console.log(event);
          this.map.setFeatureState(
            { source: 'my-data', sourceLayer: 'inspections-areas', id: this.hoveredPolygonId },
            { hover: true }
          );
        }
      })

      // When the user moves their mouse over the state-fill layer, we'll update the
      // feature state for the feature under the mouse.
      this.map.on('mousemove', 'my-data-polygons', (e) => {
          this.map.getCanvas().style.cursor = 'pointer';
        if (e.features.length > 0) {
          if (this.hoveredPolygonId !== null) {
            this.map.setFeatureState(
              { source: 'my-data', sourceLayer: 'inspections-areas' , id: this.hoveredPolygonId },
              { hover: false }
            );
          }
          this.hoveredPolygonId = e.features[0].id;
          this.map.setFeatureState(
            { source: 'my-data', sourceLayer: 'inspections-areas', id: this.hoveredPolygonId },
            { hover: true }
          );
        }
      });

      this.map.on('mouseleave', 'my-data-polygons', (e) => {
        if (this.hoveredPolygonId) {
          this.map.getCanvas().style.cursor = '';
          this.map.setFeatureState(
            { source: 'my-data', sourceLayer: 'inspections-areas', id: this.hoveredPolygonId },
            { hover: false }
          );
        }
      })

      // this.map.on('mouseenter', 'my-data-polygons', (e) => {
      //   const isPopupOpen = popup.isOpen();
      //   if (!isPopupOpen) {
      //     console.log('A mouseenter event occurred on a visible portion of the my-data-polygons-layer layer.');
      //     console.log(e);
      //     // Change the cursor style as a UI indicator.
      //     this.map.getCanvas().style.cursor = 'pointer';

      //     // Copy coordinates array.
      //     const coordinates = e.features[0].geometry.coordinates.slice();
      //     const description = e.features[0].properties.description;
      //     console.log(coordinates.sort((a, b) => a[0] - b[0]));

      //     // Ensure that if the map is zoomed out such that multiple
      //     // copies of the feature are visible, the popup appears
      //     // over the copy being pointed to.
      //     while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
      //       coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
      //     }

      //     // Populate the popup and set its coordinates
      //     // based on the feature found.
      //     popup.setLngLat(e.lngLat).setHTML(description).addTo(this.map);
      //   }

      // });

      // this.map.on('mouseleave', 'my-data-polygons', () => {
      //   this.map.getCanvas().style.cursor = '';
      //   popup.remove();
      // });

      console.log(this.map.getSource('my-data'))

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

    this.map.on('mouseenter', layerId, (e) => {
      this.addSourcePopup(e)

      const feature = e.features[0]
      console.log(feature);
      console.log(e);
    })

    this.map.on('mouseleave', layerId, (e) => {
      this.removeSourcePopup()
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

    if (this.popup) {
      return undefined
    }

    let popHTML = `<p>`
    const properties = event.features[0].properties
    Object.entries(properties).forEach((k) => popHTML += `<strong>${k[0]}:</strong> ${k[1]}<br>`)
    popHTML += '</p>'
    this.popup = new mapboxgl.Popup({
      closeButton: false,
      closeOnClick: false
    }).setHTML(popHTML)

    // this.popup = new mapboxgl.Popup()
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
