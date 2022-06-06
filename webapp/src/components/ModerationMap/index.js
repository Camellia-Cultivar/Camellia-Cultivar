import React, { useState} from 'react';
import mapboxgl from '!mapbox-gl'; // eslint-disable-line import/no-webpack-loader-syntax

import token from './accessToken'



const ModerationMap = (props) => {
    mapboxgl.accessToken = token;
    const [lat, setLat] = useState(props.lat)
    const [lon, setLon] = useState(props.lon)
    const [zoom, setZoom] = useState(props.zoom)

  return (
    <div className={props.className}>
        <img src={`https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-s-c+064e3b(${lon},${lat})/${lon},${lat},${zoom}/${props.width}x${props.height}?access_token=${token}`} alt="" ></img>
    </div>
  )
}


export default ModerationMap