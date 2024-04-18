<?php

$con = mysqli_connect("localhost","root","","fixit");

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Validate and sanitize input data
    $name = mysqli_real_escape_string($con, $_POST['name']);
    $email = mysqli_real_escape_string($con, $_POST['email']);
    $shopName = mysqli_real_escape_string($con, $_POST['shop_name']);
    $phone = mysqli_real_escape_string($con, $_POST['phone']);
    $address = mysqli_real_escape_string($con, $_POST['address']);
    $city = mysqli_real_escape_string($con, $_POST['city']);
    $pincode = mysqli_real_escape_string($con, $_POST['pincode']);
    $Approval_status = 0;
    $Available_status = 0;
    $password = mysqli_real_escape_string($con, $_POST['password']);

    // Hash the password
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

    $insert_query = "INSERT INTO vendor (vendor_name, v_email, shop_name, v_phone, v_address, v_city, v_pincode, Approval_status, Available_status, v_password) VALUES ('$name', '$email', '$shopName', '$phone', '$address', '$city', '$pincode', '$Approval_status', '$Available_status', '$hashedPassword')";
    $result = mysqli_query($con, $insert_query);

    // Check if the insertion was successful
    if ($result) {
        // Return success response to Flutter app
        echo json_encode(['success' => true, 'message' => 'Data inserted successfully']);
    } else {
        // Return error response to Flutter app
        echo json_encode(['success' => false, 'message' => 'Failed to insert data']);
    }
}
?>
