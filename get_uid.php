<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Content-Type: application/json');

$con = mysqli_connect("localhost", "root", "", "fixit");

if (mysqli_connect_errno()) {
    echo json_encode(array("success" => false, "message" => "Failed to connect to MySQL: " . mysqli_connect_error()));
    exit();
}

$phoneNumber = $_POST['phoneNumber'] ?? '';

$phoneNumber = mysqli_real_escape_string($con, $phoneNumber);

// Query to fetch u_id based on phoneNumber
$sql = "SELECT u_id FROM users WHERE phone = '$phoneNumber'";
$result = mysqli_query($con, $sql);

if (!$result) {
    echo json_encode(array("success" => false, "message" => "Query failed: " . mysqli_error($con)));
    exit();
}

if (mysqli_num_rows($result) > 0) {
    // Fetch the result
    $row = mysqli_fetch_assoc($result);
    $uId = $row['u_id'];

    // Return u_id as JSON response
    echo json_encode(array('success' => true, 'u_id' => $uId));
} else {
    // No rows found, return empty response
    echo json_encode(array('success' => false, 'message' => 'No user found with the provided phone number.'));
}

mysqli_close($con);

?>
