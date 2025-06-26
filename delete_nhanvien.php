<?php
include "connect.php";

$MaNV = $_POST['MaNV'];

$sql = "DELETE FROM nhanvien WHERE MaNV='$MaNV'";
if (mysqli_query($conn, $sql)) {
    echo json_encode(["status" => "success"]);
} else {
    echo json_encode(["status" => "fail"]);
}
?>
