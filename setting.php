<?php
$con = mysqli_connect("localhost", "root", "", "fixit");

if (mysqli_connect_errno()) {
    echo json_encode(array("status" => "error", "message" => "Failed to connect to MySQL: " . mysqli_connect_error()));
    exit;
}

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Content-Type: application/json');

$query = "SELECT * FROM vendor WHERE v_id = " . $_GET['id']; // Assuming you're passing the user ID as a parameter
$result = mysqli_query($con, $query);

if (!$result) {
    // Handle query execution error
    die('Error executing query: ' . mysqli_error($con));
}

if (mysqli_num_rows($result) > 0) {
    // Fetch and return data as JSON
    $row = mysqli_fetch_assoc($result);
    echo json_encode($row);
} else {
    echo "No data found";
}

// Close the connection
mysqli_close($con);
?>
