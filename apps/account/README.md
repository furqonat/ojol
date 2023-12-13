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

| Query    | Type      | Description                    |
| -------- | --------- | ------------------------------ |
| `id`     | `boolean` | Mendapatkan user id            |
| `name`   | `boolean` | Mendapatkan nama user          |
| `email`  | `boolean` | Mendapatkan email user         |
| `phone`  | `boolean` | Mendapatkan nomor telepon user |
| `avatar` | `boolean` | Mendapatkan avatar user        |
| `status` | `boolean` | Mendapatkan status pengguna    |

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
    "address": "...",
    "license_image": "...",
    "id_card_image": "...",
    "vehicle": {
        "create": {
            "vehicle_type": "...", # BIKE or CAR,
            "vehicle_brand": "...",
            "vehicle_year": "...",
            "vehicle_image": "...",
            "vehicle_registration": "..." # plat nomor
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

### Table Body Daftar Driver

| Body                   | Type     | Description                                                                    |
| ---------------------- | -------- | ------------------------------------------------------------------------------ |
| `address`              | `string` | Alamat lengkap driver                                                          |
| `license_image`        | `string` | link gambar `SIM` driver                                                       |
| `id_card_image`        | `string` | link gambar `KTP` driver                                                       |
| `vehicle`              | `object` |                                                                                |
| `vehicle_type`         | `enum`   | Value yang di terima adalah `BIKE` dan `CAR`                                   |
| `vehicle_brand`        | `string` | Model kendaraan yang digunakan driver. Contoh Honda Jazz, Toyota dan lain-lain |
| `vehicle_year`         | `string` | Tahun kendaraan yang digunakan driver                                          |
| `vehicle_image`        | `string` | link gambar kendaraan yang digunakan driver                                    |
| `vehicle_registration` | `string` | plat nomor kendaraan                                                           |

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
            "vehicle_type": "...", # BIKE or CAR,
            "vehicle_brand": "...",
            "vehicle_year": "...",
            "vehicle_image": "...",
            "vehicle_registration": "..." # plat nomor
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
