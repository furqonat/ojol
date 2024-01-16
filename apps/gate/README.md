# Gate Documentation Api

Api ini digunakan sebagai Api pendukung dimana berisi 3rd party api dan gate services

## Base Url

```bash
https://gate.gentatechnology.com/
```

## Daftar Isi

- [Dana OAuth](#dana-oauth)
  - [Generate SignIn URL](#generate-signin-url)
  - [Get Dana Balance Etc](#get-dana-balance-etc)
- [Lugo Service](#lugo-services)
  - [Mendapatkan lugo services](#mendapatkan-list-active-services)
  - [Mendapatkan services fee](#mendapatkan-services-fee)
  - [Mendapatkan Price KM](#mendapatkan-harga-per-kilo-meter)

## Dana Oauth

Dana oauth ditujukan untuk semua aplikasi lugo yang dimana pengguna menghubungkan akun dana mereka ke aplikasi lugo.

### Generate SignIn URL

Berikut adlah cara menggenrate signin url untuk mengautentikasi pengguna

#### Contoh Request

```http
GET https://gate.gentatechnology.com/oauth
Content-Type: application/json
Authorization: Bearer ....
```

#### Contoh Response

```json
{
  "message": "OK",
  "signInUrl": "...."
}
```

### Mendapatkan Dana Balance Etc

Api ini digunakan untuk mendapatkan dana balance dari pengguna dan API ini hanya bisa digunakan apabila pengguna sudah selesai [apply token](#generate-signin-url). Berikut adalah cara untuk mendapatkan dana balance

#### Contoh Request

```http
GET https://gate.gentatechnology.com/oauth/profile
Content-Type: application/json
Authorization: Bearer ....
```

#### Contoh Response

```json
[
  { "resourceType": "BALANCE", "value": "10366" },
  { "resourceType": "MASK_DANA_ID", "value": "62-******1234" },
  { "resourceType": "OTT", "value": "MTA3MTQ1NTI2NjE4OTQ3MDQwOTgxMTMzNDg5MTcyMTY3M" },
  { "resourceType": "TOPUP_URL", "value": "https://url.dana.id/m/portal/topup" },
  { "resourceType": "TRANSACTION_URL", "value": "https://url.m.dana.id/m/ipg?sourcePlatform=IPG" }
]
```

## Lugo Services

Api ini digunakan untuk menampilkan list service dari aplikasi lugo

### Mendapatkan list active services

Berikut adalah contoh untuk mendapatkan lugo services.

### Contoh Request

```http
GET https://gate.gentatechnology.com/lugo/services
Content-Type: application/json
Authorization: Bearer ...
```

### Contoh Response

```json
[
  {
    "service_type": "FOOD",
    "enable": true,
    "id": "..."
  },
  {
    "service_type": "MART",
    "enable": true,
    "id": "..."
  },
  {
    "service_type": "BIKE",
    "enable": true,
    "id": "..."
  },
  {
    "service_type": "CAR",
    "enable": true,
    "id": "..."
  },
  {
    "service_type": "DELIVERY",
    "enable": true,
    "id": "..."
  }
]
```

### Mendapatkan services fee

Berikut adalah contoh untuk mendapatkan services fee.

### Contoh Request

```http
GET https://gate.gentatechnology.com/lugo/fee
Content-Type: application/json
Authorization: Bearer ...
```

### Contoh Response

```json
{
  "data": [
    {
      "id": "clqwbdco60001qtw2p5f7orta",
      "service_type": "BIKE",
      "percentage": 2,
      "account_type": "REGULAR"
    },
    {
      "id": "clqwbdo2d0002qtw2kbkol1jf",
      "service_type": "BIKE",
      "percentage": 1,
      "account_type": "PREMIUM"
    },
    {
      "id": "clqwbeicn0003qtw2gshgxeex",
      "service_type": "CAR",
      "percentage": 4,
      "account_type": "BASIC"
    },
    {
      "id": "clqwbeqd60004qtw2jmp6lkkr",
      "service_type": "CAR",
      "percentage": 3,
      "account_type": "REGULAR"
    },
    {
      "id": "clqwbfqlp0005qtw2xfjs5h8a",
      "service_type": "CAR",
      "percentage": 2,
      "account_type": "PREMIUM"
    },
    {
      "id": "clqwb7rrs0000qtw2fhuiplxg",
      "service_type": "BIKE",
      "percentage": 2,
      "account_type": "BASIC"
    }
  ]
}
```

### Mendapatkan harga per kilo meter

Berikut adalah contoh untuk mendapatkan harga perkilo meter.

### Contoh Request

```http
POST https://gate.gentatechnology.com/lugo/fee/distance
Content-Type: application/json
Authorization: Bearer ...
{
  "distance": 12.8,
  "service_type": "BIKE"
}
```

### Contoh Response

```json
{
  "message": "OK",
  "price": 13000
}
```

### Mendapatkan list discount

Berikut adalah contoh untuk mendapatkan harga perkilo meter.

### Contoh Request

```http
GET https://gate.gentatechnology.com/lugo/discount
Content-Type: application/json
Authorization: Bearer ...
```

### Contoh Response

```json
[
  {
    "id": "asdasda",
    "code": "RIDE5K",
    "expired_at": "2024-01-10T10:48:00Z",
    "status": true,
    "created_at": "2024-01-09T03:48:05.008Z",
    "max_discount": 5000,
    "amount": 5000,
    "trx_type": "BIKE",
    "min_transaction": 20000
  }
]
```

## Mendapatkan banner image

Berikut adalah cara penggunaan

### Contoh Request

```http
GET http://localhost:3000/lugo/banner
Content-Type: application/json
Authorization: Bearer ....
```

### Contoh Reponse

```json
[
  {
    "id": "clquqbgf90000122wjcveawb9",
    "position": "TOP",
    "url": "https://api.gentatechnology.com/gate/portal/banner/clquqbgf90000122wjcveawb9",
    "description": "lorem",
    "status": false,
    "for_app": true,
    "images": [
      {
        "id": "clr49o59s0004p180k1b5yw0b",
        "link": "https://firebasestorage.googleapis.com/v0/b/lumajanglugo.appspot.com/o/images%2FScreenshot%20from%202024-01-07%2009-11-28.png?alt=media\u0026token=aee8a227-c649-49ac-abbf-aa7359b7bed4",
        "banner_id": "clquqbgf90000122wjcveawb9"
      }
    ]
  },
  {
    "id": "clr21uq1v0000t4pp4b3ng2m7",
    "position": "TOP",
    "status": false,
    "for_app": true,
    "images": [
      {
        "id": "clr49o59s0004p180k1b5yw0b",
        "link": "https://firebasestorage.googleapis.com/v0/b/lumajanglugo.appspot.com/o/images%2FScreenshot%20from%202024-01-07%2009-11-28.png?alt=media\u0026token=aee8a227-c649-49ac-abbf-aa7359b7bed4",
        "banner_id": "clquqbgf90000122wjcveawb9"
      }
    ]
  }
]
```

### Table Response

| Query      | Type           | Description                                                                         |
| ---------- | -------------- | ----------------------------------------------------------------------------------- |
| `id`       | `String`       | Id banner                                                                           |
| `position` | `String`       | posisi banner atas atau bawah (`TOP` or `BOTTOM`)                                   |
| `status`   | `boolean`      | Mendapatkan detail kendaraan driver                                                 |
| `for_app`  | `boolean`      | apabila `true` digunakan untuk aplikasi `customer` apabila `false` untuk `merchant` |
| `images`   | `string array` |                                                                                     |
| `link`     | `String`       | Gambar banner                                                                       |
