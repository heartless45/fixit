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

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"));

    if (isset($data->vId)) {
        $vId = intval($data->vId);

        $sql = "SELECT users.u_name AS customer_name, booking_details.amount FROM booking_details INNER JOIN users ON booking_details.u_id = users.u_id WHERE booking_details.v_id = $vId AND booking_details.booking_status = 0";

        $result = mysqli_query($con, $sql);

        if ($result) {
            $bookings = array();
            while ($row = mysqli_fetch_assoc($result)) {
                $bookings[] = $row;
            }
            echo json_encode($bookings); // Return as a JSON array
        } else {
            echo json_encode(array("status" => "error", "message" => "Error fetching bookings: " . mysqli_error($con)));
        }
    } else {
        echo json_encode(array("status" => "error", "message" => "Required fields missing"));
    }
} else {
    echo json_encode(array("status" => "error", "message" => "Invalid request method"));
}

mysqli_close($con);
?>
