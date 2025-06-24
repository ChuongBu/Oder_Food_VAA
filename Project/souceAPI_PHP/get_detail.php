<?php
include "connect.php";
$MaMonAn = $_GET['id'];
$sql = "SELECT * FROM monan WHERE MaMonAn = '$MaMonAn'";
$result = mysqli_query($conn, $sql);
$row = mysqli_fetch_assoc($result);
echo json_encode($row);
?>
