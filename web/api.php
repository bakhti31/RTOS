<?php

// // File: api.php

// // Set header untuk menanggapi permintaan JSON
// header('Content-Type: application/json');

// // Membuat koneksi ke database MySQL
// $servername = "localhost";
// $username = "root";
// $password = "";
// $dbname = "rtos";

// $conn = new mysqli($servername, $username, $password, $dbname);

// // Periksa koneksi
// if ($conn->connect_error) {
//     die("Koneksi gagal: " . $conn->connect_error);
// }

// // $sql_equipment = "CREATE TABLE Equipment (
// //     equipment_id INT AUTO_INCREMENT PRIMARY KEY,
// //     equipment_name VARCHAR(255),
// //     equipment_type VARCHAR(100),
// //     serial_number VARCHAR(50),
// //     location VARCHAR(100)
// // )";

// // $sql_maintenance_schedule = "CREATE TABLE Maintenance_Schedule (
// //     schedule_id INT AUTO_INCREMENT PRIMARY KEY,
// //     equipment_id INT,
// //     maintenance_type VARCHAR(100),
// //     last_maintenance_date DATE,
// //     next_maintenance_date DATE,
// //     maintenance_description TEXT,
// //     FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
// // )";

// // $sql_condition_monitoring = "CREATE TABLE Condition_Monitoring (
// //     monitoring_id INT AUTO_INCREMENT PRIMARY KEY,
// //     equipment_id INT,
// //     timestamp DATETIME,
// //     temperature DECIMAL(5,2),
// //     pressure DECIMAL(8,2),
// //     vibration DECIMAL(8,2),
// //     other_parameters TEXT,
// //     FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
// // )";

// // $sql_repair_history = "CREATE TABLE Repair_History (
// //     repair_id INT AUTO_INCREMENT PRIMARY KEY,
// //     equipment_id INT,
// //     repair_date DATE,
// //     issue_description TEXT,
// //     repair_action TEXT,
// //     downtime_hours DECIMAL(6,2),
// //     FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
// // )";

// // $sql_spareparts = "CREATE TABLE Spare_Parts (
// //     part_id INT AUTO_INCREMENT PRIMARY KEY,
// //     part_name VARCHAR(255),
// //     part_number VARCHAR(50),
// //     quantity_available INT,
// //     location VARCHAR(100)
// // )";

// // if ($conn->query($sql_equipment) === FALSE || $conn->query($sql_condition_monitoring) === FALSE || $conn->query($sql_maintenance_schedule) === FALSE|| $conn->query($sql_repair_history) === FALSE|| $conn->query($sql_spareparts) === FALSE) {
// //     http_response_code(500);
// //     echo json_encode(['error' => 'Connection Error: ' . $conn->error]);
// // }

// print_r($_SERVER);

// // Mendapatkan metode HTTP
// $method = $_SERVER['REQUEST_METHOD'];

// // Mendapatkan endpoint dari URL
// $request = explode('/', trim($_SERVER['QUERY_STRING'], '/'));

// // Mendapatkan data yang dikirimkan (jika ada)
// $input = json_decode(file_get_contents('php://input'), true);

// // Mendapatkan tabel yang diminta
// $table = preg_replace('/[^a-z0-9_]+/i', '', array_shift($request));

// // Mendapatkan ID (jika ada)
// $key = array_shift($request) + 0;

// // Mendefinisikan respon awal
// $response = array();

// // Routing API berdasarkan metode HTTP
// switch ($method) {
//     case 'GET':
//         // GET /api/table
//         if ($key === 0) {
//             $result = $conn->query("SELECT * FROM $table");
//             if ($result->num_rows > 0) {
//                 while ($row = $result->fetch_assoc()) {
//                     $response[] = $row;
//                 }
//             }
//         } 
//         // GET /api/table/id
//         else {
//             $result = $conn->query("SELECT * FROM $table WHERE id=$key");
//             if ($result->num_rows > 0) {
//                 $response = $result->fetch_assoc();
//             }
//         }
//         break;
//     case 'POST':
//         // POST /api/table
//         $sql = "INSERT INTO $table (column1, column2, ...) VALUES ('".$input['value1']."', '".$input['value2']."', ...)";
//         if ($conn->query($sql) === TRUE) {
//             $response = array("message" => "Data berhasil ditambahkan");
//         } else {
//             $response = array("error" => "Error: " . $sql . "<br>" . $conn->error);
//         }
//         break;
//     case 'PUT':
//         // PUT /api/table/id
//         $sql = "UPDATE $table SET column1='".$input['value1']."', column2='".$input['value2']."' WHERE id=$key";
//         if ($conn->query($sql) === TRUE) {
//             $response = array("message" => "Data berhasil diperbarui");
//         } else {
//             $response = array("error" => "Error: " . $sql . "<br>" . $conn->error);
//         }
//         break;
//     case 'DELETE':
//         // DELETE /api/table/id
//         $sql = "DELETE FROM $table WHERE id=$key";
//         if ($conn->query($sql) === TRUE) {
//             $response = array("message" => "Data berhasil dihapus");
//         } else {
//             $response = array("error" => "Error: " . $sql . "<br>" . $conn->error);
//         }
//         break;
// }

// // Menutup koneksi database
// $conn->close();

// // Mengirimkan respon JSON
// echo json_encode($response);


// // Set header untuk menanggapi permintaan JSON
// header('Content-Type: application/json');

// // Fungsi untuk membuat koneksi ke database MySQL
// function connectDB() {
//     $servername = "localhost";
//     $username = "root";
//     $password = "";
//     $dbname = "rtos";

//     $conn = new mysqli($servername, $username, $password, $dbname);

//     // Periksa koneksi
//     if ($conn->connect_error) {
//         die("Koneksi gagal: " . $conn->connect_error);
//     }

//     return $conn;
// }

// // Mendapatkan metode HTTP
// $method = $_SERVER['REQUEST_METHOD'];

// // Mendapatkan endpoint dari URL
// $request = $_SERVER['REQUEST_URI'];

// // Menghapus tanda / di depan endpoint jika ada
// $request = trim($request, '/');

// // Mengekstrak endpoint dan parameter (jika ada)
// $requestParts = explode('?', $request);
// // print_r($requestParts);
// $endpoint = explode('=',explode('&',$requestParts[1])[0])[0];
// // print($endpoint);

// $parameters = $endpoint;
// // print_r($parameters);
// // Routing API berdasarkan endpoint
// switch ($endpoint) {
//     case 'equipment':
//         switch ($method) {
//             case 'POST':
//                 // Menambahkan peralatan baru
//                 $input = json_decode(file_get_contents('php://input'), true);
//                 $conn = connectDB();
//                 $equipment_name = $input['equipment_name'];
//                 $equipment_type = $input['equipment_type'];
//                 $serial_number = $input['serial_number'];
//                 $location = $input['location'];
//                 $sql = "INSERT INTO Equipment (equipment_name, equipment_type, serial_number, location) VALUES ('$equipment_name', '$equipment_type', '$serial_number', '$location')";
//                 if ($conn->query($sql) === TRUE) {
//                     echo json_encode(array("message" => "Data berhasil ditambahkan"));
//                 } else {
//                     echo json_encode(array("error" => "Error: " . $sql . "<br>" . $conn->error));
//                 }
//                 $conn->close();
//                 break;
//             case 'GET':
//                 // Mendapatkan daftar semua peralatan
//                 $conn = connectDB();
//                 $sql = "SELECT * FROM Equipment";
//                 $result = $conn->query($sql);
//                 if ($result->num_rows > 0) {
//                     $data = array();
//                     while ($row = $result->fetch_assoc()) {
//                         $data[] = $row;
//                     }
//                     echo json_encode($data);
//                 } else {
//                     echo json_encode(array());
//                 }
//                 $conn->close();
//                 break;
            
//             default:
//                 echo json_encode(array("error" => "Metode HTTP tidak didukung"));
//         }
//         break;
//     default:
//         echo json_encode(array("error" => "Endpoint tidak ditemukan"));
// }













//////////////////////////////////////////////////////////////////////
//                Ini Bagian Pentingnya
//
//////////////////////////////////////////////////////////////////////////

// Set header untuk menanggapi permintaan JSON
header('Content-Type: application/json');

// Fungsi untuk membuat koneksi ke database MySQL
function connectDB() {
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "rtos";

    $conn = new mysqli($servername, $username, $password, $dbname);

    // Periksa koneksi
    if ($conn->connect_error) {
        die("Koneksi gagal: " . $conn->connect_error);
    }

    return $conn;
}

// // Mendapatkan metode HTTP
$method = $_SERVER['REQUEST_METHOD'];

// Mendapatkan endpoint dari URL
$request = $_SERVER['REQUEST_URI'];

// Menghapus tanda / di depan endpoint jika ada
$request = trim($request, '/');

// Mengekstrak endpoint dan parameter (jika ada)
$requestParts = explode('?', $request);
// print_r($requestParts);
$endpoint = explode('=',explode('&',$requestParts[1])[0])[0];
// print($endpoint);

$parameters = $endpoint;
// print_r($parameters);
// Routing API berdasarkan endpoint
switch ($endpoint) {
    case 'equipment':
        switch ($method) {
            case 'GET':
                // Mendapatkan daftar semua peralatan
                $conn = connectDB();
                $sql = "SELECT * FROM Equipment";
                $result = $conn->query($sql);
                if ($result->num_rows > 0) {
                    $data = array();
                    while ($row = $result->fetch_assoc()) {
                        $data[] = $row;
                    }
                    echo json_encode($data);
                } else {
                    echo json_encode(array());
                }
                $conn->close();
                break;
            case 'POST':
                // Menambahkan peralatan baru
                $input = json_decode(file_get_contents('php://input'), true);
                $conn = connectDB();
                $equipment_name = $input['equipment_name'];
                $equipment_type = $input['equipment_type'];
                $serial_number = $input['serial_number'];
                $location = $input['location'];
                $sql = "INSERT INTO Equipment (equipment_name, equipment_type, serial_number, location) VALUES ('$equipment_name', '$equipment_type', '$serial_number', '$location')";
                if ($conn->query($sql) === TRUE) {
                    echo json_encode(array("message" => "Data berhasil ditambahkan"));
                } else {
                    echo json_encode(array("error" => "Error: " . $sql . "<br>" . $conn->error));
                }
                $conn->close();
                break;
            default:
                echo json_encode(array("error" => "Metode HTTP tidak didukung"));
        }
        break;
    case 'maintenance-schedule':
        switch ($method) {
            case 'GET':
                // Mendapatkan daftar semua jadwal maintenance
                $conn = connectDB();
                $sql = "SELECT * FROM Maintenance_Schedule";
                $result = $conn->query($sql);
                if ($result->num_rows > 0) {
                    $data = array();
                    while ($row = $result->fetch_assoc()) {
                        $data[] = $row;
                    }
                    echo json_encode($data);
                } else {
                    echo json_encode(array());
                }
                $conn->close();
                break;
            case 'POST':
                // Menambahkan jadwal maintenance baru
                // Implementasi POST untuk maintenance schedule
                break;
            default:
                echo json_encode(array("error" => "Metode HTTP tidak didukung"));
        }
        break;
    case 'condition-monitoring':
        switch ($method) {
            case 'GET':
                // Mendapatkan daftar semua data monitoring condition
                $conn = connectDB();
                $sql = "SELECT * FROM Condition_Monitoring";
                $result = $conn->query($sql);
                if ($result->num_rows > 0) {
                    $data = array();
                    while ($row = $result->fetch_assoc()) {
                        $data[] = $row;
                    }
                    echo json_encode($data);
                } else {
                    echo json_encode(array());
                }
                $conn->close();
                break;
            case 'POST':
                // Menambahkan data monitoring condition baru
                // Implementasi POST untuk condition monitoring
                break;
            default:
                echo json_encode(array("error" => "Metode HTTP tidak didukung"));
        }
        break;
    case 'sparepart':
    switch ($method) {
        case 'GET':
            // Mendapatkan daftar semua sparepart
            $conn = connectDB();
            $sql = "SELECT * FROM Spare_Parts";
            $result = $conn->query($sql);
            if ($result->num_rows > 0) {
                $data = array();
                while ($row = $result->fetch_assoc()) {
                    $data[] = $row;
                }
                echo json_encode($data);
            } else {
                echo json_encode(array());
            }
            $conn->close();
            break;
        case 'POST':
            // Menambahkan sparepart baru
            $input = json_decode(file_get_contents('php://input'), true);
            $conn = connectDB();
            $part_name = $input['part_name'];
            $part_number = $input['part_number'];
            $quantity_available = $input['quantity_available'];
            $location = $input['location'];
            $sql = "INSERT INTO Spare_Parts (part_name, part_number, quantity_available, location) VALUES ('$part_name', '$part_number', '$quantity_available', '$location')";
            if ($conn->query($sql) === TRUE) {
                echo json_encode(array("message" => "Data berhasil ditambahkan"));
            } else {
                echo json_encode(array("error" => "Error: " . $sql . "<br>" . $conn->error));
            }
            $conn->close();
            break;
        default:
            echo json_encode(array("error" => "Metode HTTP tidak didukung"));
    }
    break;
    case 'sparepart':
        switch ($method) {
            case 'GET':
                // Mendapatkan daftar semua sparepart
                $conn = connectDB();
                $sql = "SELECT * FROM Spare_Parts";
                $result = $conn->query($sql);
                if ($result->num_rows > 0) {
                    $data = array();
                    while ($row = $result->fetch_assoc()) {
                        $data[] = $row;
                    }
                    echo json_encode($data);
                } else {
                    echo json_encode(array());
                }
                $conn->close();
                break;
            case 'POST':
                // Menambahkan sparepart baru
                $input = json_decode(file_get_contents('php://input'), true);
                $conn = connectDB();
                $part_name = $input['part_name'];
                $part_number = $input['part_number'];
                $quantity_available = $input['quantity_available'];
                $location = $input['location'];
                $sql = "INSERT INTO Spare_Parts (part_name, part_number, quantity_available, location) VALUES ('$part_name', '$part_number', '$quantity_available', '$location')";
                if ($conn->query($sql) === TRUE) {
                    echo json_encode(array("message" => "Data berhasil ditambahkan"));
                } else {
                    echo json_encode(array("error" => "Error: " . $sql . "<br>" . $conn->error));
                }
                $conn->close();
                break;
            default:
                echo json_encode(array("error" => "Metode HTTP tidak didukung"));
        }
        break;    
    default:
        echo json_encode(array("error" => "Endpoint tidak ditemukan"));
}
