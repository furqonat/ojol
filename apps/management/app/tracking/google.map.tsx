'use client'

import React, { useCallback, useEffect, useRef, useState } from 'react'
import { Loader } from '@googlemaps/js-api-loader'
import { useDriver } from '../../hooks/use.driver'

export function GoogleMap({ children }: { children?: React.ReactNode }) {
  const mapRef = useRef<HTMLDivElement>(null)
  const [map, setMap] = useState<google.maps.Map | null>(null)
  const { drivers } = useDriver()

  const initMap = useCallback(async () => {
    let currentMap: google.maps.Map
    const loader = new Loader({
      apiKey: process.env.NEXT_PUBLIC_GM_API as string,
      version: 'weekly',
    })
    const { Map } = (await loader.importLibrary(
      'maps',
    )) as google.maps.MapsLibrary

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        currentMap = new Map(mapRef.current as HTMLElement, {
          center: {
            lat: position.coords.latitude,
            lng: position.coords.longitude,
          },
          zoom: 10,
          disableDefaultUI: true,
        })
        setMap(currentMap)
      })
    } else {
      currentMap = new Map(mapRef.current as HTMLElement, {
        center: { lat: -6.327630415744252, lng: 106.45266467541946 },
        zoom: 10,
        disableDefaultUI: true,
      })
      setMap(currentMap)
    }
  }, [])

  useEffect(() => {
    initMap().then()
  }, [initMap])

  useEffect(() => {
    if (map) {
      drivers?.forEach((item) => {
        const location = new google.maps.LatLng(item.latitude, item.longitude)
        const marker = new google.maps.Marker({
          position: location,
          title: item.name,
          icon: {
            url: item.type === 'CAR' ? '/car.png' : '/bike.png',
          },
        })
        marker.setMap(map)
      })
    }
  }, [drivers, map])

  return (
    <div
      ref={mapRef}
      className={'flex-1 min-h-screen lg:min-h-full min-w-full relative'}
    >
      {children}
    </div>
  )
}
