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

$cartId = $_POST['cart_id']; 

$sql_delete_cart_item = "DELETE FROM cart WHERE c_id = $cartId";

if (mysqli_query($con, $sql_delete_cart_item)) {
    echo json_encode(array("success" => true, "message" => "Cart item deleted successfully."));
} else {
    echo json_encode(array("success" => false, "message" => "Failed to delete cart item: " . mysqli_error($con)));
}

mysqli_close($con);
?>
