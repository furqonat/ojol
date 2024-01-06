# Product Documentation Api

Api ini hanya bisa digunakan untuk merchant dan pengguna.

## Base Url

```bash
https://product.gentatechnology.com
```

## Daftar isi

- [Mendapatkan Semua Produk](#mendapatkan-semua-produk)
  - [Query Parameter Produk](#query-parameter-produk)
  - [Query Parameter `_count`](#query-parameter-_count)
- [Mendapatkan Detail Produk](#mendapatkan-detail-produk)
  - [Query Parameter Produk](#query-parameter-produk-1)
  - [Query Parameter `_count`](#query-parameter-_count-1)
- [Menambahkan atau menghapus produk dari favorite](#menambahkan-atau-menghapus-produk-ke-favorite-customer-only)
- [Mendapatkan Merchants](#mendapatkan-merchants)
  - [Table Query Merchant](#table-query-merchant)
  - [Table Query Merchant Detail](#table-query-details)
- [Menambahkan Produk](#menambahkan-produk-merchant-only)
  - [Table Body Produk](#table-body-menambahkan-produk)
- [Edit Produk](#edit-produk-merchant-only)
  - [Table Body Edit Produk](#table-body-edit-produk)
- [Membuat Kategori Baru](#membuat-kategori-baru)
  - [Table Body Kategori](#table-body-menambahkan-kategori)
- [Mendapatkan kategori](#mendpatkan-kategori)
  - [Table Query Kategori](#table-query-kategori)

## Mendapatkan semua produk

By default response produk hanya akan menampilakan output `id` dan `name` dari produk, tetapi kita tetap bisa untuk mendapatkan detail dari produk seperti nama merchant dan lainnya.

### Query parameter produk

| Query         | Type      | Description               |
| ------------- | --------- | ------------------------- |
| `id`          | `boolean` | Id produk                 |
| `name`        | `boolean` | nama produk               |
| `description` | `boolean` | deskripsi produk          |
| `price`       | `boolean` | harga produk              |
| `_count`      | `object`  | total relationship produk |

### Query parameter `_count`

| Query                     | Type      | Description                              |
| ------------------------- | --------- | ---------------------------------------- |
| `customer_product_review` | `boolean` | total review customer                    |
| `favorites`               | `boolean` | total pengguna yang menambahkan favorite |

### Contoh Request

```http
GET https://product.gentatechnology.com/?id=true&name=true&_count={select: {customer_product_review: true}}
Content-Type: application/json
Authorization: Bearer .....
```

### Contoh Response

```json
{
  "data": [
    {
      "id": "clq7ltn610000yn3zrmm352ix",
      "name": "Test product",
      "_count": { "customer_product_review": 0 }
    },
    {
      "id": "clq7lwafe0000dev6sha807w5",
      "name": "Test product 1",
      "_count": { "customer_product_review": 0 }
    },
    {
      "id": "clq7m09gj0001dev6y4kcvpvp",
      "name": "Test product",
      "_count": { "customer_product_review": 0 }
    }
  ],
  "total": 3
}
```

## Mendapatkan detail produk

By default response produk hanya akan menampilakan output `id` dan `name` dari produk, tetapi kita tetap bisa untuk mendapatkan detail dari produk seperti nama merchant dan lainnya.

### Query parameter produk

| Query         | Type                  | Description                                      |
| ------------- | --------------------- | ------------------------------------------------ |
| `id`          | `boolean`             | Id produk                                        |
| `name`        | `boolean`             | nama produk                                      |
| `description` | `boolean`             | deskripsi produk                                 |
| `price`       | `boolean`             | harga produk                                     |
| `_count`      | `object`              | total relationship produk                        |
| `query`       | `string`              | keyword yang digunakan untuk mencari produk      |
| `type`        | `enum`                | type product `FOOD` atau `MART` default = `FOOD` |
| `category`    | `object` or `boolean` | category produk                                  |
| `merchant_id` | `string`              | mendapatkan produk dari merchant id              |
| `filter`      | `string`              | category produk                                  |

### Query parameter `_count`

| Query                     | Type      | Description                              |
| ------------------------- | --------- | ---------------------------------------- |
| `customer_product_review` | `boolean` | total review customer                    |
| `favorites`               | `boolean` | total pengguna yang menambahkan favorite |

### Contoh Request

```http
GET https://product.gentatechnology.com/<product_id>?id=true&name=true&_count={select: {customer_product_review: true}}
Content-Type: application/json
Authorization: Bearer .....
```

### Contoh Response

```json

{
  "id": "clq7ltn610000yn3zrmm352ix",
  "name": "Test product",
  "_count": { "customer_product_review": 0 }
},

```

## Menambahkan atau menghapus produk ke favorite (Customer Only)

Api ini hanya digunakan untuk aplikasi customer

### Contoh request

```http
GET https://product.gentatechnology.com/favorite/<product_id>
Content-Type: application/json
Authorization: Bearer .....
```

### Contoh response

```json
{
  "message": "OK",
  "res": "..."
}
```

## Mendapatkan Merchants

Api ini hanya di kususkan untuk aplikasi merchant jadi selain pengguna dari aplikasi merchant semua request akan di tolak.

### Table Query Merchant

| Body      | Type               | Description                      |
| --------- | ------------------ | -------------------------------- |
| `id`      | `boolean`          | id merchant                      |
| `avatar`  | `boolean`          | gambar merchant                  |
| `type`    | `boolean`          | type merchant `FOOD` atau `MART` |
| `details` | `boolean` `object` | detail merchant                  |

### Table Query `details`

| Body             | Type      | Description          |
| ---------------- | --------- | -------------------- |
| `address`        | `boolean` | alamat merchant      |
| `name`           | `boolean` | nama toko merchant   |
| `images`         | `boolean` | gambar toko merchant |
| `operation_time` | `boolean` | jam buka merchant    |

### Contoh Request

```http
GET https://product.gentatechnology.com/merchant?id=true&details={select: {address: true, name: true, images: true}}
Content-Type: application/json
Authorization: Bearer .....
```

### Contoh Response

```json
{
  "id": "...",
  "details": {
    "address": "...",
    "name": "...",
    "images": ["...", "..."]
  }
}
```

## Menambahkan produk (Merchant only)

Api ini hanya di kususkan untuk aplikasi merchant jadi selain pengguna dari aplikasi merchant semua request akan di tolak.

### Table Body Menambahkan Produk

| Body          | Type      | Description      |
| ------------- | --------- | ---------------- |
| `name`        | `string`  | nama produk      |
| `description` | `string`  | deskripsi produk |
| `image`       | `string`  | gambar produk    |
| `price`       | `int`     | harga produk     |
| `status`      | `boolean` | status produk    |
| `category`    | `object`  | kategori produk  |

### Contoh Request menambahkan produk dengan kategori yang sudah ada

```http
POST https://product.gentatechnology.com/
Content-Type: application/json
Authorization: Bearer .....

{
    "name": "test produk",
    "description": "....",
    "status": true,
    "product_type": "FOOD",
    "category": {
        "connect": {
            "id": "...."
        }
    }
}
```

### Contoh Request menambahkan produk dengan kategori yang belum ada

```http
POST https://product.gentatechnology.com/
Content-Type: application/json
Authorization: Bearer .....

{
    "name": "test produk",
    "description": "....",
    "status": true,
    "product_type": "FOOD",
    "category": {
        "create": {
            "name": "Nasi Goreng"
        }
    }
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": "...."
}
```

## Edit Produk (Merchant only)

Api ini hanya di kususkan untuk aplikasi merchant jadi selain pengguna dari aplikasi merchant semua request akan di tolak.

### Table Body Edit Produk

| Body          | Type      | Description      |
| ------------- | --------- | ---------------- |
| `name`        | `string`  | nama produk      |
| `description` | `string`  | deskripsi produk |
| `image`       | `string`  | gambar produk    |
| `price`       | `int`     | harga produk     |
| `status`      | `boolean` | status produk    |

### Contoh Request menambahkan produk dengan kategori yang sudah ada

```http
POST https://product.gentatechnology.com/
Content-Type: application/json
Authorization: Bearer .....

{
    "name": "test produk",
    "description": "....",
    "status": true,
    ....
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": ".."
}
```

## Membuat Kategori Baru

Berikut adalah cara membuat kategori baru

### Table Body Menambahkan Kategori

| Body   | Type     | Description   |
| ------ | -------- | ------------- |
| `name` | `string` | nama kategori |

```http
POST https://product.gentatechnology.com/category/
Content-Type: application/json
Authorization: Bearer .....

{
  "name": "Nasi Goreng"
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": ".."
}
```

## Mendpatkan Kategori

Berikut adalah cara membuat kategori baru

### Table Query Kategori

| Body   | Type  | Description                   |
| ------ | ----- | ----------------------------- |
| `take` | `int` | jumlah output yang didapatkan |
| `skip` | `int` | jumlah output yang dilewatkan |

```http
GET https://product.gentatechnology.com/categories?take=10&skip=0
Content-Type: application/json
Authorization: Bearer .....

```

### Contoh Response

```json
{
  "data": [
    {
      "name": "...",
      "id": "..."
    }
     {
      "name": "...",
      "id": "..."
    }
  ],
  "total": 10
}
```
