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
$service_name = $_POST['service']; // Assuming you pass the service name from the Flutter app


$sql_select_service_id = "SELECT * FROM services WHERE s_name = '$service_name'";
$result_select_service_id = mysqli_query($con, $sql_select_service_id);

if (mysqli_num_rows($result_select_service_id) > 0) {
    $row = mysqli_fetch_assoc($result_select_service_id);
    $service_id = $row['s_id'];
    $vendor_id = $row['v_id'];

    // Insert data into the cart table
    $sql_insert_into_cart = "INSERT INTO `cart`(`v_id`, `u_id`, `s_id`) VALUES ('$vendor_id','$uid','$service_id')";
    if (mysqli_query($con, $sql_insert_into_cart)) {
        echo json_encode(array("success" => true, "message" => "Product added to cart successfully."));
    } else {
        echo json_encode(array("success" => false, "message" => "Failed to add product to cart: " . mysqli_error($con)));
    }
} else {
    echo json_encode(array("success" => false, "message" => "Service ID not found."));
}

// Close connection
mysqli_close($con);

?>
