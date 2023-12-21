# Utility Documentation Api

Api ini digunakan sebagai Api pendukung dimana berisi 3rd party api dan utility services

## Base Url

```bash
https://api.gentatechnology/utility
```

## Daftar Isi

- [Dana OAuth](#dana-oauth)
  - [Generate SignIn URL](#generate-signin-url)
  - [Get Dana Balance Etc](#get-dana-balance-etc)
- [Lugo Service](#lugo-services)
  - [Mendapatkan lugo services](#mendapatkan-list-active-services)

## Dana Oauth

Dana oauth ditujukan untuk semua aplikasi lugo yang dimana pengguna menghubungkan akun dana mereka ke aplikasi lugo.

### Generate SignIn URL

Berikut adlah cara menggenrate signin url untuk mengautentikasi pengguna

#### Contoh Request

```http
GET https://api.gentatechnology/utility/oauth
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
GET https://api.gentatechnology/utility/oauth/profile
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
GET https://api.gentatechnology/utility/oauth/lugo/services
Content-Type: application/json
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
