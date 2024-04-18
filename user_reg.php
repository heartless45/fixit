<?php

// Database connection
$con = mysqli_connect("localhost", "root", "", "fixit");

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Content-Type: application/json');

// Check connection
if (mysqli_connect_errno()) {
    echo json_encode(array("success" => false, "message" => "Failed to connect to MySQL: " . mysqli_connect_error()));
    exit();
}

// Get data sent from Flutter app
$phoneno = $_POST['phoneno'];
$name = $_POST['name'];
$email = $_POST['email'];
$address = $_POST['address'];
$landmark = $_POST['landmark'];
$pincode = $_POST['pincode'];
$city = $_POST['city'];

// Prepared statement to prevent SQL injection
$stmt = $con->prepare("INSERT INTO users (email, u_name, phone, u_address, landmark,city, pincode) VALUES (?, ?, ?, ?, ?, ?, ?)");
$stmt->bind_param("sssssss", $email, $name, $phoneno, $address,$landmark, $city, $pincode);

// Execute the statement
if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'Data inserted successfully']);
} else {
    echo json_encode(['success' => false, 'message' => 'Failed to insert data']);
}

// Close statement and connection
$stmt->close();
$con->close();
?>
