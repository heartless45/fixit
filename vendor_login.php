<?php

$con = mysqli_connect("localhost", "root", "", "fixit");

if (mysqli_connect_errno()) {
    echo json_encode(array("status" => "error", "message" => "Failed to connect to MySQL: " . mysqli_connect_error()));
}

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header("Content-Type: application/json");

$email = $_POST['email'];
$password = $_POST['password'];

$sql = "SELECT * FROM vendor WHERE v_email = '$email'";
$result = mysqli_query($con, $sql);

if ($result) {
    if (mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
            $hashedPassword = $row['v_password'];
            $approval_status = $row['approval_status'];

            if (password_verify($password, $hashedPassword)) {
                if ($approval_status == 1) {
                    $v_id = $row['v_id'];
                    echo json_encode(array("status" => "success", "message" => "Login successful","v_id" => $v_id));
                } else {
                    echo json_encode(array("status" => "error", "message" => "Your account is not approved yet."));
                }
            } else {
                echo json_encode(array("status" => "error", "message" => "Invalid email or password"));
            }
    
    } else {
        echo json_encode(array("status" => "error", "message" => "User not found"));
    }
} else {
    echo json_encode(array("status" => "error", "message" => "Database error: " . mysqli_error($con)));
}


mysqli_close($con);

?>