import {
  DocumentData,
  QueryDocumentSnapshot,
  QuerySnapshot,
} from 'firebase/firestore'

interface Converter<D, P, R = unknown> {
  toFirestore(data: D): DocumentData
  fromFirestore(snapshot: P): R
}

export class Driver {
  constructor(
    readonly name: string,
    readonly address: string,
    readonly latitude: number,
    readonly longitude: number,
    readonly isOnline: boolean,
    readonly type: 'CAR' | 'BIKE',
  ) {}
}

export const driver: Converter<Driver, QueryDocumentSnapshot> = {
  toFirestore(driver): DocumentData {
    return {
      name: driver.name,
      address: driver.address,
      latitude: driver.latitude,
      longitude: driver.longitude,
      isOnline: driver.isOnline,
      type: driver.type,
    }
  },
  fromFirestore(snapshot): Driver {
    const data = snapshot.data()
    return new Driver(
      data.name,
      data.address,
      data.latitude,
      data.longitude,
      data.isOnline,
      data.type,
    )
  },
}

export const drivers: Converter<Driver, QuerySnapshot, Driver[]> = {
  toFirestore: function (data: Driver): DocumentData {
    return {
      name: data.name,
      address: data.address,
      latitude: data.latitude,
      longitude: data.longitude,
      isOnline: data.isOnline,
      type: data.type,
    }
  },
  fromFirestore: function (
    snapshot: QuerySnapshot<DocumentData, DocumentData>,
  ): Driver[] {
    return snapshot.docs.map((item) => {
      const data = item.data()
      return new Driver(
        data.name,
        data.address,
        data.latitude,
        data.longitude,
        data.isOnline,
        data.type,
      )
    })
  },
}
