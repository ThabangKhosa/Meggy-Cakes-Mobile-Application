<?php
    $db = mysqli_connect('localhost','root','','meggycakes');
    if (!$db) {
        echo "Database connection failed";
    }

    $return["error"] = false;
    $return["message"] = "";

    $email = $_POST['cust_email'];
    $password = $_POST['cust_password'];

    $sql = "SELECT * FROM tbl_customer WHERE cust_email = '".$email."' AND cust_password = '".$password."'";
    $result = mysqli_query($db,$sql);
    $count = mysqli_num_rows($result);
    if ($count == 1) {
        $return["success"] = true;
        $return["cust_id"] = $obj->cust_id;
        $return["cust_name"] = $obj->cust_name;
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
    header('Content-Type: application/json');
   // tell browser that its a json data
   echo json_encode($return);
  //converting array to JSON string
?>