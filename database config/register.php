<?php
    $db = mysqli_connect('localhost','root','','meggycakes');
    if (!$db) {
        echo "Database connection failed";
    }

    $name = $_POST['cust_name'];
    $email = $_POST['cust_email'];
    $phone = $_POST['cust_phone'];
    $address = $_POST['cust_address'];
    $city = $_POST['cust_city'];
    $state = $_POST['cust_state'];
    $zip = $_POST['cust_zip'];
    $password = $_POST['cust_password'];


    $sql = "SELECT cust_email FROM tbl_customer WHERE cust_email = '".$email."'";

    $result = mysqli_query($db,$sql);
    $count = mysqli_num_rows($result);

    if ($count == 1) {
        echo json_encode("Error");
    }else{
        $token = md5(time());
        $cust_datetime = date('Y-m-d h:i:s');
        $cust_timestamp = time();
        $insert = "INSERT INTO tbl_customer(cust_name,cust_email,cust_phone,cust_country,cust_address,cust_city,cust_state,cust_zip,cust_password,cust_token,cust_datetime,cust_timestamp,cust_status)
        VALUES('".$name."','".$email."','".$phone."',200,'".$address."','".$city."','".$state."','".$zip."','".$password."',$token,$cust_datetime,$cust_timestamp,1)";
        $query = mysqli_query($db,$insert);
        if ($query) {
            echo json_encode("Success");
        }
    }
?>