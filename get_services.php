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
// Fetch products from the database
$sql = "SELECT * FROM services"; // Assuming 'products' is the name of your table
$result = $con->query($sql);

if ($result->num_rows > 0) {
    $products = array();

    // Fetch products data
    while ($row = $result->fetch_assoc()) {
        $products[] = $row;
    }

    echo json_encode($products);
} else {
    
    echo json_encode(array("message" => "No products found."));
}
// Close connection
$con->close();
?>
