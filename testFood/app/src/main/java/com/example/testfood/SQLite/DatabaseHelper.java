package com.example.testfood.SQLite;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.*;
import com.example.testfood.model.*;

import java.text.SimpleDateFormat;
import java.util.*;

public class DatabaseHelper extends SQLiteOpenHelper {

    public static final String DB_NAME = "OrderFoodd.db";
    public static final int DB_VERSION = 1;

    private static DatabaseHelper instance;

    public static synchronized DatabaseHelper getInstance(Context context) {
        if (instance == null) {
            instance = new DatabaseHelper(context.getApplicationContext());
        }
        return instance;
    }

    public DatabaseHelper(Context context) {
        super(context, DB_NAME, null, DB_VERSION);
    }


    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("CREATE TABLE User (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT, role TEXT)");
        db.execSQL("CREATE TABLE MonAn (id INTEGER PRIMARY KEY AUTOINCREMENT, ten TEXT, gia INTEGER, hinhAnh TEXT)");
        db.execSQL("CREATE TABLE NhanVien (id INTEGER PRIMARY KEY AUTOINCREMENT, tenNV TEXT, sdt TEXT)");
        db.execSQL("CREATE TABLE BanAn (id INTEGER PRIMARY KEY AUTOINCREMENT, soBan INTEGER, trangThai TEXT)");
        db.execSQL("CREATE TABLE DonHang (id INTEGER PRIMARY KEY AUTOINCREMENT, idBan INTEGER, ngay TEXT, tongTien REAL)");
        db.execSQL("CREATE TABLE ChiTietDonHang (id INTEGER PRIMARY KEY AUTOINCREMENT, idDonHang INTEGER, idMonAn INTEGER, soLuong INTEGER)");

        // Dữ liệu mẫu
        db.execSQL("INSERT INTO User(username, password, role) VALUES ('admin','123','admin'), ('nv1','123','nhanvien')");
        db.execSQL("INSERT INTO BanAn(soBan, trangThai) VALUES (1, 'Trống'), (2, 'Trống'), (3, 'Trống')");
        db.execSQL("INSERT INTO MonAn(ten, gia, hinhAnh) VALUES " +
                "('Pizza', 120000, 'pizza.png'), " +
                "('Coca', 15000, 'coca.png'), " +
                "('Salad', 40000, 'salad.png')");
    }


    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS User");
        db.execSQL("DROP TABLE IF EXISTS MonAn");
        db.execSQL("DROP TABLE IF EXISTS NhanVien");
        db.execSQL("DROP TABLE IF EXISTS BanAn");
        db.execSQL("DROP TABLE IF EXISTS DonHang");
        db.execSQL("DROP TABLE IF EXISTS ChiTietDonHang");

        onCreate(db); // tạo lại bảng với cấu trúc mới
    }

    // Kiểm tra tài khoản đã tồn tại
    public boolean kiemTraTaiKhoanTonTai(String username) {
        SQLiteDatabase db = getReadableDatabase();
        Cursor c = db.rawQuery("SELECT * FROM User WHERE username = ?", new String[]{username});
        boolean tonTai = c.moveToFirst();
        c.close();
        return tonTai;
    }

    // Hàm đăng ký tài khoản mới cho admin (true = thành công, false = thất bại)
    public boolean dangKyAdmin(String username, String password) {
        if (kiemTraTaiKhoanTonTai(username)) {
            return false; // tài khoản đã tồn tại
        }

        SQLiteDatabase db = getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("username", username);
        values.put("password", password);
        values.put("role", "admin");

        long result = db.insert("User", null, values);
        return result != -1;
    }

    // ==== USER ====
    public User kiemTraDangNhap(String user, String pass) {
        SQLiteDatabase db = getReadableDatabase();
        Cursor c = db.rawQuery("SELECT * FROM User WHERE username=? AND password=?", new String[]{user, pass});
        if (c.moveToFirst()) {
            return new User(c.getInt(0), c.getString(1), c.getString(2), c.getString(3));
        }
        return null;
    }
    public void capNhatMonAn(MonAn mon) {
        SQLiteDatabase db = getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("ten", mon.getTen());
        values.put("gia", mon.getGia());
        values.put("hinhAnh", mon.getHinhAnh());
        db.update("MonAn", values, "id = ?", new String[]{String.valueOf(mon.getId())});
    }


    // ==== MON AN ====
    public void themMonAn(MonAn mon) {
        SQLiteDatabase db = getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("ten", mon.getTen());
        values.put("gia", mon.getGia());
        values.put("hinhAnh", mon.getHinhAnh());
        db.insert("MonAn", null, values);
    }

    public void suaMonAn(MonAn mon) {
        SQLiteDatabase db = getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("ten", mon.getTen());
        values.put("gia", mon.getGia());
        values.put("hinhAnh", mon.getHinhAnh());
        db.update("MonAn", values, "id=?", new String[]{String.valueOf(mon.getId())});
    }

    public void xoaMonAn(int id) {
        SQLiteDatabase db = getWritableDatabase();
        db.delete("MonAn", "id=?", new String[]{String.valueOf(id)});
    }

    public ArrayList<MonAn> getDanhSachMonAn() {
        ArrayList<MonAn> list = new ArrayList<>();
        SQLiteDatabase db = getReadableDatabase();
        Cursor c = db.rawQuery("SELECT * FROM MonAn", null);
        while (c.moveToNext()) {
            MonAn mon = new MonAn(
                    c.getInt(c.getColumnIndexOrThrow("id")),
                    c.getString(c.getColumnIndexOrThrow("ten")),
                    c.getInt(c.getColumnIndexOrThrow("gia")),
                    c.getString(c.getColumnIndexOrThrow("hinhAnh"))
            );
            list.add(mon);
        }
        c.close();
        return list;
    }

    public MonAn getMonAnById(int id) {
        SQLiteDatabase db = getReadableDatabase();
        Cursor c = db.rawQuery("SELECT * FROM MonAn WHERE id=?", new String[]{String.valueOf(id)});
        if (c.moveToFirst()) {
            MonAn mon = new MonAn(
                    c.getInt(c.getColumnIndexOrThrow("id")),
                    c.getString(c.getColumnIndexOrThrow("ten")),
                    c.getInt(c.getColumnIndexOrThrow("gia")),
                    c.getString(c.getColumnIndexOrThrow("hinhAnh"))
            );
            c.close();
            return mon;
        }
        c.close();
        return null;
    }



    // ==== NHAN VIEN ====
    public void themNhanVien(String ten, String sdt) {
        SQLiteDatabase db = getWritableDatabase();
        db.execSQL("INSERT INTO NhanVien(tenNV, sdt) VALUES (?, ?)", new Object[]{ten, sdt});
    }

    public void suaNhanVien(int id, String ten, String sdt) {
        SQLiteDatabase db = getWritableDatabase();
        db.execSQL("UPDATE NhanVien SET tenNV=?, sdt=? WHERE id=?", new Object[]{ten, sdt, id});
    }

    public void xoaNhanVien(int id) {
        SQLiteDatabase db = getWritableDatabase();
        db.execSQL("DELETE FROM NhanVien WHERE id=?", new Object[]{id});
    }

    public ArrayList<NhanVien> getDanhSachNhanVien() {
        ArrayList<NhanVien> list = new ArrayList<>();
        SQLiteDatabase db = getReadableDatabase();
        Cursor c = db.rawQuery("SELECT * FROM NhanVien", null);
        while (c.moveToNext()) {
            list.add(new NhanVien(c.getInt(0), c.getString(1), c.getString(2)));
        }
        c.close();
        return list;
    }

    // ==== BAN AN ====
    public ArrayList<BanAn> getDanhSachBan() {
        ArrayList<BanAn> list = new ArrayList<>();
        SQLiteDatabase db = getReadableDatabase();
        Cursor c = db.rawQuery("SELECT * FROM BanAn", null);
        while (c.moveToNext()) {
            list.add(new BanAn(c.getInt(0), c.getInt(1), c.getString(2)));
        }
        c.close(); // ✅ thêm dòng này
        return list;
    }


    public void capNhatTrangThaiBan(int idBan, String trangThai) {
        SQLiteDatabase db = getWritableDatabase();
        db.execSQL("UPDATE BanAn SET trangThai=? WHERE id=?", new Object[]{trangThai, idBan});
    }

    public BanAn getBanAnById(int id) {
        SQLiteDatabase db = getReadableDatabase();
        Cursor c = db.rawQuery("SELECT * FROM BanAn WHERE id=?", new String[]{String.valueOf(id)});
        if (c.moveToFirst()) {
            return new BanAn(c.getInt(0), c.getInt(1), c.getString(2));
        }
        return null;
    }

    // ==== DON HANG ====
    public int themDonHang(int idBan, double tongTien) {
        SQLiteDatabase db = getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("idBan", idBan);
        values.put("ngay", new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.getDefault()).format(new Date()));
        values.put("tongTien", tongTien);
        return (int) db.insert("DonHang", null, values);
    }

    public ArrayList<DonHang> getDanhSachDonHang() {
        ArrayList<DonHang> list = new ArrayList<>();
        SQLiteDatabase db = getReadableDatabase();
        Cursor c = db.rawQuery("SELECT * FROM DonHang ORDER BY id DESC", null);
        while (c.moveToNext()) {
            list.add(new DonHang(
                    c.getInt(0),
                    c.getInt(1),
                    c.getString(2),
                    c.getDouble(3)
            ));
        }
        return list;
    }

    // ==== CHI TIET DON HANG ====
    public void themChiTietDonHang(int idDonHang, int idMonAn, int soLuong) {
        SQLiteDatabase db = getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("idDonHang", idDonHang);
        values.put("idMonAn", idMonAn);
        values.put("soLuong", soLuong);
        db.insert("ChiTietDonHang", null, values);
    }

    public ArrayList<ChiTietDonHang> getChiTietDonHang(int idDonHang) {
        ArrayList<ChiTietDonHang> list = new ArrayList<>();
        SQLiteDatabase db = getReadableDatabase();
        Cursor c = db.rawQuery("SELECT * FROM ChiTietDonHang WHERE idDonHang=?", new String[]{String.valueOf(idDonHang)});
        while (c.moveToNext()) {
            list.add(new ChiTietDonHang(c.getInt(0), c.getInt(1), c.getInt(2), c.getInt(3)));
        }
        return list;
    }

    // ==== THỐNG KÊ DOANH THU ====
    public double getDoanhThuTheoNgay(String ngay) {
        SQLiteDatabase db = getReadableDatabase();
        Cursor c = db.rawQuery("SELECT SUM(tongTien) FROM DonHang WHERE ngay LIKE ?", new String[]{ngay + "%"});
        if (c.moveToFirst()) return c.getDouble(0);
        return 0;
    }

    public double getDoanhThuTheoThang(String thangNam) {
        SQLiteDatabase db = getReadableDatabase();
        Cursor c = db.rawQuery("SELECT SUM(tongTien) FROM DonHang WHERE ngay LIKE ?", new String[]{thangNam + "%"});
        if (c.moveToFirst()) return c.getDouble(0);
        return 0;
    }

    public double getDoanhThuTuNgayDenNgay(String tuNgay, String denNgay) {
        SQLiteDatabase db = getReadableDatabase();
        Cursor c = db.rawQuery("SELECT SUM(tongTien) FROM DonHang WHERE date(ngay) BETWEEN ? AND ?", new String[]{tuNgay, denNgay});
        if (c.moveToFirst()) return c.getDouble(0);
        return 0;
    }
}
