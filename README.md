API Documentation

```sql
CREATE TABLE Equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_name VARCHAR(255),
    equipment_type VARCHAR(100),
    serial_number VARCHAR(50),
    location VARCHAR(100)
);

CREATE TABLE Maintenance_Schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_id INT,
    maintenance_type VARCHAR(100),
    last_maintenance_date DATE,
    next_maintenance_date DATE,
    maintenance_description TEXT,
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
);

CREATE TABLE Condition_Monitoring (
    monitoring_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_id INT,
    timestamp DATETIME,
    temperature DECIMAL(5,2),
    pressure DECIMAL(8,2),
    vibration DECIMAL(8,2),
    other_parameters TEXT,
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
);

CREATE TABLE Repair_History (
    repair_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_id INT,
    repair_date DATE,
    issue_description TEXT,
    repair_action TEXT,
    downtime_hours DECIMAL(6,2),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
);

CREATE TABLE Spare_Parts (
    part_id INT AUTO_INCREMENT PRIMARY KEY,
    part_name VARCHAR(255),
    part_number VARCHAR(50),
    quantity_available INT,
    location VARCHAR(100)
);
```

### EndPoint

- **GET /equipment**: Mendapatkan daftar semua peralatan.
- **GET /equipment/{id}**: Mendapatkan detail peralatan berdasarkan ID.
- **POST /equipment**: Menambahkan peralatan baru.
- **PUT /equipment/{id}**: Memperbarui detail peralatan berdasarkan ID.
- **DELETE /equipment/{id}**: Menghapus peralatan berdasarkan ID.



### Endpoint Response:

#### GET /equipment
- Deskripsi: Mendapatkan daftar semua peralatan.
- Response:
  ```json
  [
    {
      "equipment_id": 1,
      "equipment_name": "Excavator",
      "equipment_type": "Heavy Equipment",
      "serial_number": "EXC12345",
      "location": "Tambang A"
    },
    {
      "equipment_id": 2,
      "equipment_name": "Dump Truck",
      "equipment_type": "Heavy Equipment",
      "serial_number": "DMP54321",
      "location": "Tambang B"
    },
    ...
  ]
  ```

#### GET /equipment/{id}
- Deskripsi: Mendapatkan detail peralatan berdasarkan ID.
- Response:
  ```json
  {
    "equipment_id": 1,
    "equipment_name": "Excavator",
    "equipment_type": "Heavy Equipment",
    "serial_number": "EXC12345",
    "location": "Tambang A"
  }
  ```

#### POST /equipment
- Deskripsi: Menambahkan peralatan baru.
- Request Body:
  ```json
  {
    "equipment_name": "Bulldozer",
    "equipment_type": "Heavy Equipment",
    "serial_number": "BLD67890",
    "location": "Tambang C"
  }
  ```
- Response:
  ```json
  {
    "message": "Data berhasil ditambahkan"
  }
  ```

#### PUT /equipment/{id}
- Deskripsi: Memperbarui detail peralatan berdasarkan ID.
- Request Body:
  ```json
  {
    "equipment_name": "Bulldozer",
    "equipment_type": "Heavy Equipment",
    "serial_number": "BLD67890",
    "location": "Tambang D"
  }
  ```
- Response:
  ```json
  {
    "message": "Data berhasil diperbarui"
  }
  ```

#### DELETE /equipment/{id}
- Deskripsi: Menghapus peralatan berdasarkan ID.
- Response:
  ```json
  {
    "message": "Data berhasil dihapus"
  }
  ```
