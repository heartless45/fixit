<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Content-Type: application/json');

// Establish connection to MySQL
$con = mysqli_connect("localhost", "root", "", "fixit");

// Check connection
if (mysqli_connect_errno()) {
    echo json_encode(array("success" => false, "message" => "Failed to connect to MySQL: " . mysqli_connect_error()));
    exit();
}

$uid = mysqli_real_escape_string($con, $_POST['uid']); 

$sql_select_user_info = "SELECT city, landmark FROM users WHERE u_id = '$uid'";

$result_select_user_info = mysqli_query($con, $sql_select_user_info);

if ($result_select_user_info) {
    if (mysqli_num_rows($result_select_user_info) > 0) {
        $row = mysqli_fetch_assoc($result_select_user_info);
        $city = $row['city'];
        $landmark = $row['landmark'];
        
        // Return user information as JSON response
        echo json_encode(array("success" => true, "city" => $city, "landmark" => $landmark));
    } else {
        // User information not found
        echo json_encode(array("success" => false, "message" => "User information not found."));
    }
} else {
    // Error occurred while executing the query
    echo json_encode(array("success" => false, "message" => "An error occurred while fetching user information."));
}

// Close connection
mysqli_close($con);

?>
