window.VALIDATION =
  map: null # Google Maps
  mapOptions:
    center: new google.maps.LatLng(-6.140555, 24.433594)
    zoom: 4
    mapTypeId: google.maps.MapTypeId.TERRAIN
    mapTypeControl: false
    panControl: false
    zoomControl: false
    rotateControl: false
    streetViewControl: false
  mapPolygon: null # Google Maps Polygon
  mapPolygonOptions:
    editable: true
  minEditZoom: 10
  mangroves: null # CartoDB Mangroves Layer
  corals: null # CartoDB Corals Layer
  currentAction: null # Current user action ['validate', 'add', 'delete']
  submitModalEvents: {}
  selectedLayer: 'mangrove'
