package com.example.testfood.utils;

import com.example.testfood.model.MonAn;

import java.util.ArrayList;

public class GioHang {
    public static int idBan = -1;
    public static ArrayList<MonAn> danhSachGioHang = new ArrayList<>();

    public static void themMon(MonAn monAn) {
        for (MonAn m : danhSachGioHang) {
            if (m.getId() == monAn.getId()) {
                m.setSoLuong(m.getSoLuong() + 1);
                return;
            }
        }
        monAn.setSoLuong(1);
        danhSachGioHang.add(monAn);
    }

    public static void clear() {
        danhSachGioHang.clear();
        idBan = -1;
    }

    public static double tinhTongTien() {
        double tong = 0;
        for (MonAn m : danhSachGioHang) {
            tong += m.getGia() * m.getSoLuong();
        }
        return tong;
    }

    public static ArrayList<MonAn> getDsMonAn() {
        return null;
    }

    public static void themMonAn(MonAn monAn) {

    }
}