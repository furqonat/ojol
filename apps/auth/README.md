# Auth Api Documentation
Dokumentasi ini digunakan untuk melakukan signin dengan firebase auth dengan custom token


## SignIn
Api ini digunakan untuk aplikikasi lugo customer, lugo driver, dan lugo merchant untuk login ke dan mendapatkan claim token untuk

### SignIn Aplikasi Customer
```http
POST https://api.gentatechnology.com/auth/customer
```

### SignIn Aplikasi Driver
```http
POST https://api.gentatechnology.com/auth/driver
```

### SignIn Aplikasi Merchant
```http
POST https://api.gentatechnology.com/auth/merchant
```

### Header Request
Ketika akan melakukan reques maka aplikasi harus menyertakan header token dari firebase untuk decode kembali dan mengirim custom token untuk digunakan untuk masuk dengan custom token 

#### Mendapatkan token 
```dart
final token = await credential.user?.getIdToken()
```

#### Mengirim token keserver dengan library http
```dart
http.post(Uri.parse('https://api.gentatechnology.com/auth/customer'), headers: {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json" // sebainya tambahkan ini untuk menghidari error yang tidak terduga
})
```

#### Contoh Response Success
```json
{
    "token": "......",
    "message": "OK"
}
```

#### Contoh Response Error
```json
{
    "token": null,
    "message": "Unauthorized"
}
```

#### Masuk menggunakan custom token yang sudah didapatkan dari server
```dart
try {
    final userCredential =
        await FirebaseAuth.instance.signInWithCustomToken(token);
} on FirebaseAuthException catch (e) {
    switch (e.code) {
        case "invalid-custom-token":
            print("The supplied token is not a Firebase custom auth token.");
            break;
        case "custom-token-mismatch":
            print("The supplied token is for a different Firebase project.");
            break;
        default:
            print("Unkown error.");
    }
}

```

