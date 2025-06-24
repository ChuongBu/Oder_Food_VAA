package com.example.oder_food;

public class Server {
    //lấy ip của máy tính 
    public static String localhost = "http://192.168.42.1/oderfood/"; // localhost cho emulator
    public static String urlRegister = localhost + "register.php";
    public static String urlLogin = localhost + "login.php";
    public static String urlGetMonAn = localhost + "get_monan.php";
    public static String urlGetDetail = localhost + "get_detail.php?id=";
}
