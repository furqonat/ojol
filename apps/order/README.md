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
    "product": [
      {
        "quantity": 1,
        "product_id": 'clq7m09gj0001dev6y4kcvpvp',
      }
    ],
    "location": {
      "latitude": -6.1231,
      "longitude": 112.1231,
      "address": "....",
    },
    "destination": {
      "latitude": -6.1231,
      "longitude": 112.1231,
      "address": "....",
    }

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
    "location": {
      "latitude": -6.1231,
      "longitude": 112.1231,
      "address": "....",
    },
    "destination": {
      "latitude": -6.1231,
      "longitude": 112.1231,
      "address": "....",
    }

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
    "weight": 1,
    "location": {
      "latitude": -6.1231,
      "longitude": 112.1231,
      "address": "....",
    },
    "destination": {
      "latitude": -6.1231,
      "longitude": 112.1231,
      "address": "....",
    }

}
```

### Contoh Response

```json
{
  "message": "Successfully create order",
  "res": "...",
  "detail": {
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
PUT https://api.gentatechnology.com/order/<order_id>
Content-Type: application/json
Authorization: Bearer ....

{
  "reason": "Tidak menerima Driver"
}
```

### Contoh Response

```json
{
  "message": "Success",
  "res": "..."
}
```

## Driver mendapatkan list order

Api ini hanya bisa digunakan di aplikasi `driver` Berikut adalah contoh mendapatkan list order.

### Contoh Request

```http
GET https://api.gentatechnology.com/order/driver
Content-Type: application/json
Authorization: Bearer ....
```

### Contoh Response

```json
{
  "data": [
    {
      "id": "clqje77u90000dmkc57v4ytmj",
      "order_type": "FOOD",
      "order_status": "FIND_DRIVER",
      "payment_type": "DANA",
      "created_at": "2023-12-24T11:14:55.474Z",
      "customer_id": "JQ1kUabfTnSlfpPl3IJrdvHl9H53",
      "gross_amount": 100000,
      "net_amount": 100000,
      "total_amount": 150000,
      "shipping_cost": 50000,
      "weight_cost": 0,
      "version": 1,
      "showable": true,
      "order_detail": {
        "id": "clqje78960002dmkcjlilv5yc",
        "order_id": "clqje77u90000dmkc57v4ytmj",
        "latitude": 0,
        "longitude": 0,
        "address": "",
        "dst_latitude": 0,
        "dst_longitude": 0,
        "dst_address": ""
      }
    }
  ],
  "total": 1
}
```

## Merchant Dan User Mencari Driver

Api ini digunakan beberapa kondisi. Ketika order type adalah `CAR`, `BIKE`, dan `DELIVERY` dan maka setelah pembayaran selesai aplikasi `customer` harus hit api ini untuk mencari driver. Sedangkan untuk order type `FOOD` dan `MART` aplikasi `merchant` yang harus hit api ini.
Berikut adalah contoh menggunakan api ini.

### Contoh Request

```http
PUT https://api.gentatechnology.com/order/driver/<order_id>
Content-Type: application/json
Authorization: Bearer ....

{
  "latitude": -6.0131,
  "longitude": 111.012441
}
```

### Contoh Response

```json
{
  "message": "OK"
}
```

## Driver Medaftarkan diri sebagai driver pada order

Ketika mencari driver di daerah terdekat dan tidak ada driver yang mengaktifkan `auto bid` maka order akan di tampilkan di aplikasi order dan driver mendaftarkan diri mereka sebagai driver dari order tersebut.
Berikut adalah cara menggunakan API ini.

### Contoh Request

```http
PUT https://api.gentatechnology.com/order/driver/sign/<order_id>
Content-Type: application/json
Authorization: Bearer ....

```

### Contoh Response

```json
{
  "message": "OK"
}
```

## Driver Menerima Order

Setelah pengguna menyelesaikan pembayaran dan pencarian driver terdekat didapatkan maka status order belum berubah sebelum driver menyetujui untuk menerima order tersebut.
Berikut adalah cara menggunakan api ini.

### Contoh Request

```http
PUT https://api.gentatechnology.com/order/driver/accept/<order_id>
Content-Type: application/json
Authorization: Bearer ....

```

### Contoh Response

```json
{
  "message": "OK"
}
```

## Driver Menolak Order

Setelah pengguna menyelesaikan pembayaran dan pencarian driver terdekat didapatkan maka status order belum berubah sebelum driver menyetujui untuk menerima order tersebut.
Berikut adalah cara menggunakan api ini.

### Contoh Request

```http
PUT https://api.gentatechnology.com/order/driver/reject/<order_id>
Content-Type: application/json
Authorization: Bearer ....

```

### Contoh Response

```json
{
  "message": "OK"
}
```

## Merchant Mendapatkan Order

Setelah pengguna menyelesaikan pembayaran pada order `FOOD` dan `MART` maka merchant akan mendapatkan notifikasi dan melihat order.
Berikut adalah cara menggunakan api ini.

### Contoh Request

```http
GET https://api.gentatechnology.com/order/merchant/
Content-Type: application/json
Authorization: Bearer ....

```

### Contoh Response

```json
{
  "data": [
    {
      "id": "clqje77u90000dmkc57v4ytmj",
      "order_type": "FOOD",
      "order_status": "FIND_DRIVER",
      "payment_type": "DANA",
      "created_at": "2023-12-24T11:14:55.474Z",
      "customer_id": "JQ1kUabfTnSlfpPl3IJrdvHl9H53",
      "gross_amount": 100000,
      "net_amount": 100000,
      "total_amount": 150000,
      "shipping_cost": 50000,
      "weight_cost": 0,
      "version": 1,
      "showable": true,
      "transactions": {
        "id": "clqje78hj0003dmkcrwe17lu0",
        "type": "FOOD",
        "status": "PAID",
        "created_at": "2023-12-24T11:14:56.312Z",
        "payment_at": "2023-12-24T11:15:36Z",
        "order_id": "clqje77u90000dmkc57v4ytmj"
      },
      "customer": {
        "id": "JQ1kUabfTnSlfpPl3IJrdvHl9H53",
        "email": "test@example.com",
        "email_verified": false,
        "phone_verified": false,
        "status": "ACTIVE"
      },
      "order_items": [
        {
          "id": "clqje78140001dmkc8we7bfoo",
          "product_id": "clq7m09gj0001dev6y4kcvpvp",
          "quantity": 1,
          "order_id": "clqje77u90000dmkc57v4ytmj"
        }
      ],
      "order_detail": {
        "id": "clqje78960002dmkcjlilv5yc",
        "order_id": "clqje77u90000dmkc57v4ytmj",
        "latitude": 0,
        "longitude": 0,
        "address": "",
        "dst_latitude": 0,
        "dst_longitude": 0,
        "dst_address": ""
      }
    }
  ]
}
```

## Merchant Menolak Order

Setelah merchant mendapatkan notifikasi ada order baru maka merchant berhak untuk menerima atau menolak order tersebut.

Berikut adalah cara menggunakan api merchant menolak order.

### Contoh Request

```http
PUT https://api.gentatechnology.com/merchant/reject/<order_id>
Content-Type: application/json
Authorization: Bearer ....

```

### Contoh Response

```json
{
  "message": "OK"
}
```

## Merchant Menerima Order

Setelah merchant mendapatkan notifikasi ada order baru maka merchant berhak untuk menerima atau menolak order tersebut.

Berikut adalah cara menggunakan api merchant menerima order.

### Contoh Request

```http
PUT https://api.gentatechnology.com/merchant/accept/<order_id>
Content-Type: application/json
Authorization: Bearer ....

```

### Contoh Response

```json
{
  "message": "OK"
}
```



## Mendapatkan Detail Order
Berikut adalah contoh mendapatkan detail order

### Contoh Request

```http
GET https://api.gentatechnology.com/order/<order_id>
Content-Type: application/json
Authorization: Bearer ....

```

### Contoh Response

```json
{
  "...."
}
```
