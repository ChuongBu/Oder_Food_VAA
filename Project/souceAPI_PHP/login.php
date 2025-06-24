<?php
include "connect.php";

$TenDN = $_POST['TenDN'];
$MatKhau = $_POST['MatKhau'];

$sql = "SELECT * FROM nhanvien WHERE TenDN='$TenDN' AND MatKhau='$MatKhau'";
$result = mysqli_query($conn, $sql);
if (mysqli_num_rows($result) > 0) {
    echo "success";
} else {
    echo "fail";
}
?>
