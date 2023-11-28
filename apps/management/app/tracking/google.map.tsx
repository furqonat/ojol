'use client'

import React, { useCallback, useEffect, useRef } from 'react'
import { Loader } from '@googlemaps/js-api-loader'

export function GoogleMap({ children }: { children?: React.ReactNode }) {
  const mapRef = useRef<HTMLDivElement>(null)

  const initMap = useCallback(async () => {
    // let map: google.maps.Map
    const loader = new Loader({
      apiKey: process.env.NEXT_PUBLIC_GM_API as string,
      version: 'weekly',
    })
    const { Map } = (await loader.importLibrary(
      'maps',
    )) as google.maps.MapsLibrary

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        new Map(mapRef.current as HTMLElement, {
          center: {
            lat: position.coords.latitude,
            lng: position.coords.longitude,
          },
          zoom: 10,
          disableDefaultUI: true,
        })
      })
    } else {
      new Map(mapRef.current as HTMLElement, {
        center: { lat: -6.327630415744252, lng: 106.45266467541946 },
        zoom: 10,
        disableDefaultUI: true,
      })
    }
  }, [])

  useEffect(() => {
    initMap().then()
  }, [initMap])

  return (
    <div ref={mapRef} className={'flex-1 min-h-full min-w-full'}>
      {children}
    </div>
  )
}
