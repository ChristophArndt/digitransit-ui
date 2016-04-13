{VectorTile}  = require 'vector-tile'
Protobuf      = require 'pbf'

scaleratio = (window?.devicePixelRatio or 1)
citybikeImageSize = 18 * scaleratio

# TODO: IE doesn't support innerHTML for svg elements, so icon has to be duplicated
citybikeImageText = """
  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024" width="#{citybikeImageSize}" height="#{citybikeImageSize}">
    <path fill="rgb(251, 184, 0)" class="path1 fill-color12" d="M0.043 126.755c0-69.114 57.594-126.709 126.709-126.709h767.931c71.676 0 129.27 57.594 129.27 126.709v767.931c0 71.672-57.594 129.27-129.27 129.27h-767.928c-69.114 0-126.709-57.594-126.709-129.27v-767.931z"></path>
    <path fill="rgb(255, 255, 255)" class="path2 fill-color14" d="M618.11 553.786c3.811-15.075 10.816-29.583 19.143-42.512l24.522 28.56c-2.323 4.573-5.101 10.35-6.419 13.951h-37.245z"></path>
    <path fill="rgb(255, 255, 255)" class="path3 fill-color14" d="M257.817 750.129c-3.533 0-7.077-0.119-10.628-0.368-41.352-2.789-79.157-21.523-106.479-52.764-27.278-31.208-40.774-71.181-37.946-112.562 5.458-81.184 73.442-144.793 154.716-144.793 3.522 0 7.084 0.108 10.646 0.329 7.861 0.545 15.7 1.687 23.33 3.374l-13.308 33.463c-4.129-0.715-8.287-1.199-12.445-1.467-2.749-0.21-5.509-0.289-8.226-0.289-62.706 0-115.17 49.090-119.408 111.778-2.175 31.913 8.208 62.767 29.305 86.899 21.057 24.113 50.254 38.571 82.195 40.706 2.778 0.21 5.556 0.318 8.316 0.318 62.684 0 115.102-49.101 119.317-111.807 2.005-29.662-6.221-57.833-24.54-81.075l14.905-37.043c2.175 2.222 4.942 5.585 6.987 7.948 27.271 31.208 40.774 71.199 37.967 112.562-5.48 81.213-73.424 144.793-154.705 144.793z"></path>
    <path fill="rgb(255, 255, 255)" class="path4 fill-color14" d="M761.656 611.698l-219.207 0.061 13.189-35.417h170.81l-105.626-138.063 16.722-37.729 138.767 182.789c5.914 7.742 4.425 18.836-3.305 24.789-2.063 1.579-4.624 2.619-7.749 3.175l-3.038 0.455-0.564-0.061z"></path>
    <path fill="rgb(255, 255, 255)" class="path5 fill-color14" d="M305.307 394.85c-6.669 14.678-9.548 24.204-27.556 23.022-8.594-0.574-14.378-0.842-22.358-1.976-14.685-2.113-21.473-9.327-30.327-22.448-8.663-12.882-26.415-39.694-38.831-59.809-4.862-7.879-2.142-16.99 9.27-16.99h143.669c-5.437 13.807-27.18 63.493-33.867 78.2z"></path>
    <path fill="rgb(255, 255, 255)" class="path6 fill-color14" d="M542.421 612.959h-40.926c-23.080 0-29.623-17.672-33.116-27.17-8.453-22.766-23.369-63.291-32.527-90.681-24.767-74.067-40.496-74.067-64.303-74.067-10.935 0-19.797-8.88-19.797-19.825 0-10.935 8.861-19.807 19.797-19.807 46.135 0 73.146 15.133 101.894 101.128 8.97 26.841 23.727 66.914 31.707 88.416 0.336 0.892 0.614 1.676 0.853 2.363h36.418c10.924 0 19.807 8.883 19.807 19.825 0 10.946-8.88 19.818-19.807 19.818z"></path>
    <path fill="rgb(255, 255, 255)" class="path7 fill-color14" d="M535.994 611.759l-1.478-2.164-0.108 2.056h-0.448c-6.817 0-12.196-2.959-15.411-7.868l-0.249-1.687 12.087-38.751 100.742-225.579h-32.686c-16.036 0-29.077-13.038-29.077-29.077l-0.029-2.005h148.77v2.005c0 16.036-13.059 29.077-29.106 29.077h-19.074l-107.905 241.434-12.326 31.288-1.857 1.272h-11.845z"></path>
    <path fill="rgb(255, 255, 255)" class="path8 fill-color14" d="M352.754 427.417c-2.373 0-4.783-0.466-7.095-1.438-9.349-3.93-13.735-14.688-9.815-24.023l49.119-116.846c2.879-6.806 9.537-11.235 16.921-11.235h47.851c10.14 0 18.348 8.208 18.348 18.337 0 10.14-8.208 18.359-18.348 18.359h-35.666l-44.398 105.604c-2.948 7.015-9.754 11.242-16.917 11.242z"></path>
    <path fill="rgb(255, 255, 255)" class="path9 fill-color14" d="M901.782 518.705c0.376 0.665 2.102 3.782 2.46 4.436 11.571 22.239 17.586 47.107 17.354 72.868-0.686 84.876-70.296 153.922-155.153 153.922h-1.358c-41.468-0.336-80.331-16.791-109.405-46.363-18.637-18.962-32.162-42.404-39.069-67.778l37.093-0.029c5.816 16.563 14.688 30.226 27.209 42.989 22.448 22.813 52.435 35.515 84.449 35.804h1.051c65.506 0 119.231-53.328 119.794-118.851 0.159-19.508-4.295-38.354-12.922-55.264l28.495-21.733z"></path>
    <path fill="rgb(255, 255, 255)" class="path10 fill-color14" d="M709.225 445.653l84.655 110.506c0 0 99.85-72.142 105.276-76.133 9.378-6.925 7.861-15.946-0.802-21.722-14.32-9.537-43.029-30.952-115.636-30.952-51.236 0.004-73.493 18.301-73.493 18.301z"></path>
    <path fill="rgb(255, 255, 255)" class="path11 fill-color14" d="M262.437 607.702c-6.846 0-12.969-3.829-15.946-10.003-2.063-4.216-2.352-9.038-0.802-13.496 1.557-4.465 4.772-8.078 9.049-10.133 16.173-7.828 19.2-14.457 29.362-41.32 7.323-19.471 41.699-104.286 56.384-140.505l0.853-2.095 3.244-0.715 24.511 23.022 0.477 2.222c-16.78 41.439-45.897 113.472-52.374 130.603-10.577 27.964-17.575 46.392-47.067 60.643-2.442 1.192-5.032 1.777-7.691 1.777z"></path>
  </svg>"""

citybikeImage = new Image(citybikeImageSize, citybikeImageSize)
citybikeImage.src = "data:image/svg+xml;base64,#{btoa(citybikeImageText)}"


class CityBikes
  constructor: (@tile) ->
    @name = "citybike"
    @promise = fetch("http://localhost:8001/hsl-citybike-map/#{@tile.coords.z + (@tile.props.zoomOffset or 0)}/#{@tile.coords.x}/#{@tile.coords.y}.pbf").then (res) =>
      if res.status != 200
        return
      res.arrayBuffer().then (buf) =>
        vt = new VectorTile(new Protobuf(buf))
        @features = [0..vt.layers.stations?.length - 1]
          .map((i) -> vt.layers.stations.feature i)
        for i in @features
          @addFeature i
        return
      , (err) -> console.log err

  addFeature: (feature) =>
    geom = feature.loadGeometry()
    @tile.ctx.drawImage citybikeImage,
      (geom[0][0].x / @tile.ratio) - citybikeImageSize / 2,
      (geom[0][0].y / @tile.ratio) - citybikeImageSize / 2


module.exports = CityBikes
