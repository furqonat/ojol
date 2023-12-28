# Account Api Documentation

Dokumentasi ini ditujukan untuk setiap pengguna di aplikasi lugo, Customer, Driver dan Merchant.

## Base Url

Api ini menggunakan domain yang sama dengan domain auth api tetapi menggunakan path yang berbeda. berikut adalah base url

### Base url customer

```bash
https://api.gentatechnology.com/account/customer
```

### Base url driver

```bash
https://api.gentatechnology.com/account/driver
```

### Base url merchant

```bash
https://api.gentatechnology.com/account/merchant
```

## Mendapatkan Akun

Untuk mendapatkan akun by default api akan menampilkan result `id` saja pada response. Setiap request harus menyertakan `Bearer` token. Berikut adalah cara penggunaa:

### Contoh Request

```http
GET https://api.gentatechnology.com/account/customer
Authorization: Bearer .....
Content-Type: application/json
```

### Contoh Response

```json
{
  "id": "......"
}
```

## Mendapatkan Akun Detail

Untuk mendapatkan detail pengguna api account menggunakan query parameter pada url. Setiap request harus menyertakan `Bearer` token. Berikut adalah cara mendapatkan detail pengguna:

### Contoh Request

```http
GET https://api.gentatechnology.com/account/customer?id=true&name=true&email=true
Authorization: Bearer .....
Content-Type: application/json
```

### Contoh Response

```json
{
  "id": "......",
  "name": "....",
  "email": "...."
}
```

### Table Query Parameter

| Query            | Type                  | Description                                    |
| ---------------- | --------------------- | ---------------------------------------------- |
| `id`             | `boolean`             | Mendapatkan user id                            |
| `name`           | `boolean`             | Mendapatkan nama user                          |
| `email`          | `boolean`             | Mendapatkan email user                         |
| `phone`          | `boolean`             | Mendapatkan nomor telepon user                 |
| `avatar`         | `boolean`             | Mendapatkan avatar user                        |
| `status`         | `boolean`             | Mendapatkan status pengguna                    |
| `driver_details` | `boolean` or `object` | mendapatkan driver detail (hanya untuk driver) |

### Table Query Parameter `driver_details`

| Query           | Type      | Description                         |
| --------------- | --------- | ----------------------------------- |
| `id`            | `boolean` | Mendapatkan user id                 |
| `adrress`       | `boolean` | Mendapatkan alamat user             |
| `vehicle`       | `boolean` | Mendapatkan detail kendaraan driver |
| `driver_id`     | `boolean` | Mendapatkan id driver               |
| `license_image` | `boolean` | Mendapatkan gambar `SIM`            |
| `id_card_image` | `boolean` | Mendapatkan gamnar `KTP`            |
| `badge`         | `boolean` | Mendapatkan badge driver            |
| `driver_type`   | `boolean` | Mendapatkan detail type driver      |

## Simpan Device Token

Api ini digunakan untuk menyimpan device token firebase ke database. Device token digunakan untuk mengirim push notifikasi ke hp

### Contoh Request

```http
GET https://api.gentatechnology.com/customer/token
Authorization: Bearer .....
Content-Type: application/json

{
  "token": "...."
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": "..."
}
```

## Update Akun Dasar Customer

Berikut adalah cara untuk update dasar akun customer

### Contoh Request

```http
PUT https://api.gentatechnology.com/account/customer
Authorization: Bearer ...
Content-Type: application/json

{
    "name": "....",
    "avatar": "...."
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": "...."
}
```

### Table Body Update Akun Customer

| Body          | Type     | Description                  |
| ------------- | -------- | ---------------------------- |
| `name`        | `string` | Update nama user             |
| `avatar`      | `string` | Link gambar poto profil user |
| `email`       | `string` | email pengguna               |
| `phoneNumber` | `string` | Nomor telepon pengguna       |

## Mendaftarkan Diri Sebagai Driver

Api ini hanya bisa digunakan di aplikasi `Lugo Driver`

### Contoh Request

```http
POST https://api.gentatechnology.com/account/driver
Authorization: Bearer ....
Content-Type: application/json

{
    "details": {
      "address": "...",
      "license_image": "...",
      "id_card_image": "...",
      "vehicle": {
          "create": {
              "vehicle_type": "...", // BIKE or CAR,
              "vehicle_brand": "...",
              "vehicle_year": "...",
              "vehicle_image": "...",
              "vehicle_registration": "...", // FOTO stnk
              "vehicle_rn": "..." // plat nomor
          }
      }
    },
    "referal": "...",
    "name": "..."
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": "..."
}
```

### Table Body Daftar Driver

| Body                   | Type     | Description                                                                    |
| ---------------------- | -------- | ------------------------------------------------------------------------------ |
| `name`                 | `string` | Nama driver                                                                    |
| `address`              | `string` | Alamat lengkap driver                                                          |
| `license_image`        | `string` | link gambar `SIM` driver                                                       |
| `id_card_image`        | `string` | link gambar `KTP` driver                                                       |
| `vehicle`              | `object` |                                                                                |
| `vehicle_type`         | `enum`   | Value yang di terima adalah `BIKE` dan `CAR`                                   |
| `vehicle_brand`        | `string` | Model kendaraan yang digunakan driver. Contoh Honda Jazz, Toyota dan lain-lain |
| `vehicle_year`         | `string` | Tahun kendaraan yang digunakan driver                                          |
| `vehicle_image`        | `string` | link gambar kendaraan yang digunakan driver                                    |
| `vehicle_registration` | `string` | foto stnk kendaraan                                                            |
| `vehicle_rn`           | `string` | plat nomor kendaraan                                                           |

# Update Pendaftar Diri Sebagai Driver

Api ini hanya bisa digunakan di aplikasi `Lugo Driver`

### Contoh Request

```http
PUT https://api.gentatechnology.com/account/driver
Authorization: Bearer ....
Content-Type: application/json

{
    "address": "...",
    "license_image": "...",
    "id_card_image": "...",
    "vehicle": {
        "update": {
           "data": {
              "vehicle_type": "...", # BIKE or CAR,
              "vehicle_brand": "...",
              "vehicle_year": "...",
              "vehicle_image": "...",
              "vehicle_registration": "..." # plat nomor
           },
           "where": {
              "driver_details_id": "..."
           }
        }
    }
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": "..."
}
```

### Table Body Update Daftar Driver

| Body                   | Type     | Description                                                                           |
| ---------------------- | -------- | ------------------------------------------------------------------------------------- |
| `address`              | `string` | Alamat lengkap driver                                                                 |
| `license_image`        | `string` | link gambar `SIM` driver                                                              |
| `id_card_image`        | `string` | link gambar `KTP` driver                                                              |
| `vehicle`              | `object` |                                                                                       |
| `vehicle_type`         | `enum`   | Value yang di terima adalah `BIKE` dan `CAR`                                          |
| `vehicle_brand`        | `string` | Model kendaraan yang digunakan driver. Contoh Honda Jazz, Toyota Avanza dan lain-lain |
| `vehicle_year`         | `string` | Tahun kendaraan yang digunakan driver                                                 |
| `vehicle_image`        | `string` | link gambar kendaraan yang digunakan driver                                           |
| `vehicle_registration` | `string` | plat nomor kendaraan                                                                  |

# Update Titik Koordinat Driver

Api ini hanya bisa digunakan di aplikasi `Lugo Driver`

### Contoh Request

```http
PUT https://api.gentatechnology.com/account/driver/setting/coordinate
Authorization: Bearer ....
Content-Type: application/json

{
  "latitude": -6.0131,
  "longitude": 106.1312
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": "..."
}
```

### Table Body Update Koordinat Driver

| Body        | Type    | Description      |
| ----------- | ------- | ---------------- |
| `latitude`  | `float` | driver latitude  |
| `longitude` | `float` | driver longitude |

# Update Min Price transaksi driver

Api ini hanya bisa digunakan di aplikasi `Lugo Driver`

### Contoh Request

```http
PUT https://api.gentatechnology.com/account/driver/setting/order
Authorization: Bearer ....
Content-Type: application/json

{
  "ride": true,
  "ride_price": 100000
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": "..."
}
```

### Table Body Update Min Price Transaction Driver

| Body             | Type      | Description        |
| ---------------- | --------- | ------------------ |
| `ride`           | `boolean` | lugo service       |
| `ride_price`     | `int`     | min price ride     |
| `delivery`       | `boolean` | lugo service       |
| `delivery_price` | `int`     | min price delivery |
| `food`           | `boolean` | lugo service       |
| `food_price`     | `int`     | min price food     |
| `mart`           | `boolean` | lugo service       |
| `mart_price`     | `int`     | min price mart     |

# Update Driver Setting

Api ini hanya bisa digunakan di aplikasi `Lugo Driver`

### Contoh Request

```http
PUT https://api.gentatechnology.com/account/driver/setting
Authorization: Bearer ....
Content-Type: application/json

{
  "isOnline": true,
  "autoBid": true
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": "..."
}
```

### Table Body Update Min Price Transaction Driver

| Body       | Type      | Description                                       |
| ---------- | --------- | ------------------------------------------------- |
| `autoBid`  | `boolean` | menerima order secara otomatis                    |
| `isOnline` | `boolean` | jika `true` maka driver siap untuk menerima order |

## Update Merchant

Api ini hanya digunakan untuk aplikasi merchant. Berikut adalah contoh penggunaan api.

### Contoh Request

```http
PUT https://api.gentatechnology.com/account/merchant/<merchant_id>
Authorization: Bearer ....
Content-Type: application/json

{
  "is_open": true,
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": "..."
}
```

### Table body update merchant

| Body      | Type      | Description                            |
| --------- | --------- | -------------------------------------- |
| `name`    | `string`  | Nama Merchant Bukan Nama toko merchant |
| `email`   | `string`  | email login merchant                   |
| `phone`   | `string`  | nomor telepon merchant                 |
| `avatar`  | `string`  | link gambar avatar merchant bukan toko |
| `is_open` | `boolean` | toko merchant buka atau tutup          |

## Mendaftarkan diri sebagai Merchant

Api ini hanya digunakan untuk aplikasi merchant. Berikut adalah contoh penggunaan api.

### Contoh Request

```http
POST https://api.gentatechnology.com/account/merchant
Authorization: Bearer ....
Content-Type: application/json

{
  "create": {
    "id_card_image": "...",
    "address": "...",
    "latitude": 0.01213,
    "longitude": 11.1231231,
    "name": "...",
    "images": {
      "createMany": {
        "data": [
          {
            "link": "...."
          },
          {
            "link": "...."
          }
        ]
      }
    }
  }
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": "..."
}
```

### Table body daftar menjadi merchant

| Body            | Type     | Description                             |
| --------------- | -------- | --------------------------------------- |
| `create`        | `object` | Json object apply merchant              |
| `address`       | `string` | Alamat lengkap merchant                 |
| `id_card_image` | `string` | link foto ktp merchant                  |
| `latitude`      | `float`  | titik koordinat latitude toko merchant  |
| `longitude`     | `float`  | titik koordinat longitude toko merchant |
| `name`          | `string` | nama toko merchant                      |
| `images`        | `object` | kumpulan foto toko merchant             |

## Update diri sebagai Merchant

Api ini hanya digunakan untuk aplikasi merchant. Berikut adalah contoh penggunaan api.

### Contoh Request

```http
POST https://api.gentatechnology.com/account/merchant
Authorization: Bearer ....
Content-Type: application/json

{
  "update": {
    "id_card_image": "...",
    "address": "...",
    "latitude": 0.01213,
    "longitude": 11.1231231,
    "name": "...",
    "images": {
      "update": {
        "where": {
          "id": "..." // images id
        },
        "data": {
          "link": "..."
        }
      }
    }
  }
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": "..."
}
```

### Table body update menjadi merchant

| Body            | Type     | Description                             |
| --------------- | -------- | --------------------------------------- |
| `update`        | `object` | Json object update apply merchant       |
| `address`       | `string` | Alamat lengkap merchant                 |
| `id_card_image` | `string` | link foto ktp merchant                  |
| `latitude`      | `float`  | titik koordinat latitude toko merchant  |
| `longitude`     | `float`  | titik koordinat longitude toko merchant |
| `name`          | `string` | nama toko merchant                      |
| `images`        | `object` | kumpulan foto toko merchant             |

## Membuat jam operasional Merchant

Api ini hanya digunakan untuk aplikasi merchant. Berikut adalah contoh penggunaan api.

### Contoh Request

```http
POST https://api.gentatechnology.com/account/merchant/operation
Authorization: Bearer ....
Content-Type: application/json

{
  "create": {
    "day": "...",
    "status": true,
    "open_time": "...", // date time iso string
    "close_time": "..." // date time iso string
  }
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": "..."
}
```

### Table body update menjadi merchant

| Body         | Type      | Description                                 |
| ------------ | --------- | ------------------------------------------- |
| `create`     | `object`  | Json object create merchant jam operasional |
| `day`        | `string`  | hari merchant beroperasi                    |
| `status`     | `boolean` | status beroperasi                           |
| `open_time`  | `string`  | jam buka merchant                           |
| `close_tome` | `string`  | jam tutup merchant                          |

## Membuat jam operasional Merchant

Api ini hanya digunakan untuk aplikasi merchant. Berikut adalah contoh penggunaan api.

### Contoh Request

```http
PUT https://api.gentatechnology.com/account/merchant/operation/<operational_id>
Authorization: Bearer ....
Content-Type: application/json

{
  "day": "...",
  "status": true,
  "open_time": "...", // date time iso string
  "close_time": "..." // date time iso string
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": "..."
}
```

### Table body update menjadi merchant

| Body         | Type      | Description              |
| ------------ | --------- | ------------------------ |
| `day`        | `string`  | hari merchant beroperasi |
| `status`     | `boolean` | status beroperasi        |
| `open_time`  | `string`  | jam buka merchant        |
| `close_tome` | `string`  | jam tutup merchant       |
