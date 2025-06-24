<?php
include "connect.php";
$sql = "SELECT * FROM monan";
$result = mysqli_query($conn, $sql);
$mang = array();
while ($row = mysqli_fetch_assoc($result)) {
    $mang[] = $row;
}
echo json_encode($mang);
?>
