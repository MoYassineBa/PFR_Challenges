# Housni - PHP OOP Challenges

### 1) Abstract reservation system
#### Task Description
Create an abstract class `Reservation` with:
- attributes: `price`, `status`
- abstract method: `confirm()`

Create two classes extending `Reservation`:
- `HotelReservation`
- `FlightReservation`

Each class should implement `confirm()` and return a formatted confirmation message.

#### Input Data
```json
{
  "reservations": [
    { "type": "hotel", "price": 300, "status": "pending" },
    { "type": "flight", "price": 1200, "status": "pending" }
  ]
}
```

#### Expected Output
```json
[
  "Reservation hotel confirmee : 300 DH",
  "Reservation vol confirmee : 1200 DH"
]
```

### 2) Abstract transport cost calculator
#### Task Description
Create:
- an abstract class `Transport`
- attributes: `distance`, `type`
- abstract method: `calculateCost()`

Create classes:
- `BusTransport`
- `TaxiTransport`

Each class calculates trip cost using its own pricing rule.

#### Input Data
```json
{
  "trips": [
    { "type": "bus", "distance": 10 },
    { "type": "taxi", "distance": 10 }
  ]
}
```

#### Expected Output
```json
[
  "Trajet de 10 km en Bus coute 5 DH",
  "Trajet de 10 km en Taxi coute 20 DH"
]
```

### 3) Abstract vehicle rental pricing
#### Task Description
Create:
- an abstract class `Location`
- attributes: `duree`, `typeVehicule`
- abstract method: `calculerPrix()`

Create classes:
- `LocationVoiture`
- `LocationMoto`

Each class computes total price for the rental duration.

#### Input Data
```json
{
  "rentals": [
    { "type": "voiture", "duree": 2 },
    { "type": "moto", "duree": 2 }
  ]
}
```

#### Expected Output
```json
[
  "Location voiture (2 jours) coute 400 DH",
  "Location moto (2 jours) coute 150 DH"
]
```

### 4) Abstract payment with two methods
#### Task Description
Create:
- an abstract class `Paiement`
- attributes: `montant`, `methode`
- abstract method: `effectuerPaiement()`

Create classes:
- `PaiementCarte`
- `PaiementCash`

Each class returns a message describing the validated payment.

#### Input Data
```json
{
  "payments": [
    { "type": "carte", "montant": 250 },
    { "type": "cash", "montant": 120 }
  ]
}
```

#### Expected Output
```json
[
  "Paiement par carte valide : 250 DH",
  "Paiement en cash valide : 120 DH"
]
```

### 5) Abstract shipment pricing
#### Task Description
Create:
- an abstract class `Livraison`
- attributes: `poids`, `type`
- abstract method: `calculerFrais()`

Create classes:
- `LivraisonStandard`
- `LivraisonExpress`

Each class computes shipping fees with its own rule.

#### Input Data
```json
{
  "shipments": [
    { "type": "standard", "poids": 5 },
    { "type": "express", "poids": 5 }
  ]
}
```

#### Expected Output
```json
[
  "Livraison standard de 5 kg coute 25 DH",
  "Livraison express de 5 kg coute 50 DH"
]
```

### 6) Abstract subscription cost
#### Task Description
Create:
- an abstract class `Abonnement`
- attributes: `dureeMois`, `type`
- abstract method: `calculerMontant()`

Create classes:
- `AbonnementBasic`
- `AbonnementPremium`

Each class returns total subscription amount based on duration.

#### Input Data
```json
{
  "subscriptions": [
    { "type": "basic", "dureeMois": 3 },
    { "type": "premium", "dureeMois": 3 }
  ]
}
```

#### Expected Output
```json
[
  "Abonnement Basic (3 mois) coute 300 DH",
  "Abonnement Premium (3 mois) coute 750 DH"
]
```

### 7) Abstract employee bonus calculator
#### Task Description
Create:
- an abstract class `Employe`
- attributes: `nom`, `salaireBase`
- abstract method: `calculerPrime()`

Create classes:
- `Developpeur`
- `Manager`

Each class calculates bonus differently and returns a full summary.

#### Input Data
```json
{
  "employees": [
    { "type": "developpeur", "nom": "Ali", "salaireBase": 8000 },
    { "type": "manager", "nom": "Sara", "salaireBase": 10000 }
  ]
}
```

#### Expected Output
```json
[
  "Developpeur Ali : salaire 8000 DH, prime 800 DH",
  "Manager Sara : salaire 10000 DH, prime 2000 DH"
]
```
