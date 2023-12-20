# Order Documentation Api

Dokumetasi ini digunakan untuk api order bike, car, food, mart, delivery

## Base Url

```bash
https://api.gentatechnology.com/order
```

## Membuat Order Baru

Berikut adalah cara menggunaka order api

### Contoh Request FOOD dan MART

```http
POST https://api.gentatechnology.com/order
Content-Type: application/json
Authorization: Bearer ....


{
    "order_type": 'FOOD',
    "payment_type": 'DANA',
    "gross_amount": 100000,
    "net_amount": 100000,
    "total_amount": 150000,
    "shipping_cost": 50000,
    "quantity": 1,
    "product_id": 'clq7m09gj0001dev6y4kcvpvp',

}
```

### Contoh Request BIKE and CAR

```http
POST https://api.gentatechnology.com/order
Content-Type: application/json
Authorization: Bearer ....


{
    "order_type": 'FOOD',
    "payment_type": 'DANA',
    "gross_amount": 100000,
    "net_amount": 100000,
    "total_amount": 150000,
    "shipping_cost": 50000,

}
```

### Contoh Request DELIVERY

```http
POST https://api.gentatechnology.com/order
Content-Type: application/json
Authorization: Bearer ....


{
    "order_type": 'FOOD',
    "payment_type": 'DANA',
    "gross_amount": 100000,
    "net_amount": 100000,
    "total_amount": 150000,
    "shipping_cost": 50000,
    "weight": 1

}
```

### Contoh Response

```json
{
  "message": "Successfully create order",
  "res": "...",
  "dana": {
    "resultInfo": {
      // rest of result
    },
    "merchantTransId": "....",
    "acquirementId": "....",
    "checkoutUrl": "...."
  }
}
```

### Table Body Create New Order

| Body            | Type     | Description                                                   |
| --------------- | -------- | ------------------------------------------------------------- |
| `product_id`    | `string` | id produk                                                     |
| `payment_type`  | `string` | `enum` payment type `DANA` dan `CASH`                         |
| `order_type`    | `string` | enum order type `DELIVERY` `FOOD` `MART` `BIKE` `CAR`         |
| `quantity`      | `int`    | jumlah produk yang akan di masukan ke order                   |
| `gross_amount`  | `int`    | total harga sebulum ada diskon                                |
| `net_amount`    | `int`    | total harga sesudah di potong diskon                          |
| `shipping_cost` | `int`    | total harga ongkos kirim                                      |
| `total_amount`  | `int`    | total shipping cost `+` net amount                            |
| `weight`        | `int`    | berat barang dalam kg, hanya digunakan untuk order `DELIVERY` |


## Cancel Order
Berikut adalah cara melakukan pembatalan order

### Contoh Request
```http
POST https://api.gentatechnology.com/order/<order_id>
Content-Type: application/json
Authorization: Bearer ....
```
### Contoh Response

```json
{
  "message": "Success",
  "res": "...",
}
```