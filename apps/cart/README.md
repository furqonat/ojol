# Cart Documentasi Api

Dokumentasi ini hanya digunakan untuk aplikasi lugo merchant

## Base URL

```bash
https://cart.gentatechnology.com/
```

## Mendapatkan cart

Berikut adalah contoh mendapatkan cart

### Contoh Request

```http
GET https://cart.gentatechnology.com/
Content-Type: application/json
Authorization: Bearer .....
```

### Contoh Response

```json
{
  "data": {
    "id": "clqafsjyy0001ehjlerw28sz7",
    "cart_item": [
      {
        "id": "clqahl75100032p05hrh19x2a",
        "quantity": 2,
        "product_id": "clq7ltn610000yn3zrmm352ix",
        "cart_id": "clqafsjyy0001ehjlerw28sz7",
        "product": {
          "id": "clq7ltn610000yn3zrmm352ix",
          "merchant_id": "hXhO1KgeehbkVpl9PL2w4r34pQX2",
          "name": "Test product",
          "image": null,
          "description": null,
          "price": 100000,
          "product_type": "FOOD",
          "status": true
        }
      },
      {
        "id": "clqajkdui0001rt74wjcfgief",
        "quantity": 1,
        "product_id": "clq7m09gj0001dev6y4kcvpvp",
        "cart_id": "clqafsjyy0001ehjlerw28sz7",
        "product": {
          "id": "clq7m09gj0001dev6y4kcvpvp",
          "merchant_id": "hXhO1KgeehbkVpl9PL2w4r34pQX2",
          "name": "Test product",
          "image": null,
          "description": null,
          "price": 100000,
          "product_type": "FOOD",
          "status": true
        }
      }
    ]
  },
  "total": 2
}
```

## Menambahkan produk ke cart

Berikut adalah contoh menambahkan produk ke cart

### Table Body

| Body        | Type     | Description                                |
| ----------- | -------- | ------------------------------------------ |
| `productId` | `string` | id produk                                  |
| `quantity`  | `int`    | jumlah produk yang akan di masukan ke cart |

### Contoh Request

```http
POST https://cart.gentatechnology.com/
Content-Type: application/json
Authorization: Bearer .....

{
  "productId": "...",
  "quantity": 2
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": "..."
}
```

## Update produk dari cart
Berikut adalah contoh update produk dari cart
### Table Body

| Body        | Type     | Description                                |
| ----------- | -------- | ------------------------------------------ |
| `productId` | `string` | id produk                                  |
| `quantity`  | `int`    | jumlah produk yang akan di masukan ke cart |

### Contoh Request

```http
PUT https://cart.gentatechnology.com/
Content-Type: application/json
Authorization: Bearer .....

{
  "productId": "...",
  "quantity": 2
}
```

### Contoh Response

```json
{
  "message": "OK",
  "res": "..."
}
```
