<?php
include "connect.php";

$TenDN = $_POST['TenDN'];
$MatKhau = $_POST['MatKhau'];
$CCCD = $_POST['CCCD'];

$sql = "INSERT INTO nhanvien (TenDN, MatKhau, CCCD) VALUES ('$TenDN', '$MatKhau', '$CCCD')";
if (mysqli_query($conn, $sql)) {
    echo "success";
} else {
    echo "error";
}
?>
