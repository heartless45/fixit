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

$uid = $_POST['uid'];

// Fetch cart data for the user
$sql = "SELECT cart.c_id,cart.s_id, services.s_name, services.s_price FROM cart INNER JOIN services ON cart.s_id = services.s_id WHERE cart.u_id = $uid";
$result = $con->query($sql);

if ($result->num_rows > 0) {
    $service = array();

    // Fetch cart data
    while ($row = $result->fetch_assoc()) {
        $service[] = $row;
    }

    echo json_encode($service);
} else {
    echo json_encode(array("message" => "Cart is empty."));
}

// Close connection
$con->close();

?>
