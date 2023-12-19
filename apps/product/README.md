# Product Documentation Api

Api ini hanya bisa digunakan untuk merchant dan pengguna.

## Base Url

```bash
https://api.gentatechnology.com/product
```

## Medapatkan semua produk

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
GET https://api.gentatechnology.com/product/?id=true&name=true&_count={select: {customer_product_review: true}}
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

## Medapatkan detail produk

By default response produk hanya akan menampilakan output `id` dan `name` dari produk, tetapi kita tetap bisa untuk mendapatkan detail dari produk seperti nama merchant dan lainnya.

### Query parameter produk

| Query         | Type      | Description                                      |
| ------------- | --------- | ------------------------------------------------ |
| `id`          | `boolean` | Id produk                                        |
| `name`        | `boolean` | nama produk                                      |
| `description` | `boolean` | deskripsi produk                                 |
| `price`       | `boolean` | harga produk                                     |
| `_count`      | `object`  | total relationship produk                        |
| `query`       | `string`  | keyword yang digunakan untuk mencari produk      |
| `type`        | `enum`    | type product `FOOD` atau `MART` default = `FOOD` |
| `category`    | `string`  | category produk                                  |
| `merchant_id` | `string`  | mendapatkan produk dari merchant id              |

### Query parameter `_count`

| Query                     | Type      | Description                              |
| ------------------------- | --------- | ---------------------------------------- |
| `customer_product_review` | `boolean` | total review customer                    |
| `favorites`               | `boolean` | total pengguna yang menambahkan favorite |

### Contoh Request

```http
GET https://api.gentatechnology.com/product/<product_id>?id=true&name=true&_count={select: {customer_product_review: true}}
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
GET https://api.gentatechnology.com/product/favorite/<product_id>
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

### Table Query Menambahkan Produk

| Body          | Type      | Description      |
| ------------- | --------- | ---------------- |
| `name`        | `string`  | nama produk      |
| `image`       | `string`  | gambar produk    |

### Contoh Request menambahkan produk dengan kategori yang sudah ada


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
POST https://api.gentatechnology.com/product/
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
POST https://api.gentatechnology.com/product/
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

### Table Body Menambahkan Produk

| Body          | Type      | Description      |
| ------------- | --------- | ---------------- |
| `name`        | `string`  | nama produk      |
| `description` | `string`  | deskripsi produk |
| `image`       | `string`  | gambar produk    |
| `price`       | `int`     | harga produk     |
| `status`      | `boolean` | status produk    |

### Contoh Request menambahkan produk dengan kategori yang sudah ada

```http
POST https://api.gentatechnology.com/product/
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
