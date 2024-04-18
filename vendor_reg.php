<?php

// Database connection
$con = mysqli_connect("localhost", "root", "", "fixit");

// Check connection
if (mysqli_connect_errno()) {
    echo json_encode(array("status" => "error", "message" => "Failed to connect to MySQL: " . mysqli_connect_error()));
    exit();
}

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header("Content-Type: application/json");

// Retrieve POST data
$email = $_POST['email'] ?? '';

// SQL query to check if email exists
$sql = "SELECT * FROM vendor WHERE v_email = '$email'";
$result = mysqli_query($con, $sql);

if ($result) {
    if (mysqli_num_rows($result) > 0) {
        // Email already registered
        echo json_encode(array("status" => "success", "available" => false));
    } else {
        // Email available
        echo json_encode(array("status" => "success", "available" => true));
    }
} else {
    // Database error
    echo json_encode(array("status" => "error", "message" => "Database error: " . mysqli_error($con)));
}

mysqli_close($con);

?>
