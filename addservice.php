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

    if (isset($data->vId) && isset($data->Service_name) && isset($data->s_description) && isset($data->Service_price) && isset($data->image)) {
        $vId = intval($data->vId);
        $Service_name = $data->Service_name;
        $Service_category = $data->s_description;
        $isChecked = $data->isChecked;
        $Service_price = intval($data->Service_price);
        $imageData = base64_decode($data->image);

        $targetDir = "uploads/";
        $imageName = uniqid() . '.png'; 

        if($isChecked == true){
            $isc = 1;
        }else{
            $isc = 0;
        }

        if (file_put_contents($targetDir . $imageName, $imageData)) {

            $sql = "INSERT INTO `services`(`v_id`, `s_name`, `s_description`, `s_price`, `s_image`,`isChecked`) VALUES ('$vId', '$Service_name', '$Service_category', '$Service_price', '$targetDir$imageName','$isc')";
            $result = mysqli_query($con, $sql);
            
            if ($result) {
                echo json_encode(array("status" => "success", "message" => "Service added successfully"));
            } else {
                echo json_encode(array("status" => "error", "message" => "Error inserting data into database: " . mysqli_error($con)));
            }
        } else {
            echo json_encode(array("status" => "error", "message" => "Error uploading image"));
        }

        mysqli_close($con);
    } else {
        echo json_encode(array("status" => "error", "message" => "Required fields missing"));
    }
} else {
    echo json_encode(array("status" => "error", "message" => "Invalid request method"));
}
?>
