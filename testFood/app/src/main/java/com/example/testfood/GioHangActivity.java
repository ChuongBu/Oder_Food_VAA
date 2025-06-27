package com.example.testfood;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.testfood.Adapter.GioHangAdapter;
import com.example.testfood.SQLite.DatabaseHelper;
import com.example.testfood.model.MonAn;
import com.example.testfood.utils.GioHang;

public class GioHangActivity extends AppCompatActivity {

    RecyclerView recyclerGioHang;
    GioHangAdapter adapter;
    TextView txtTongTien;
    Button btnThanhToan, btnQuayLai, btnGoiMon;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_giohang);
        btnGoiMon.setOnClickListener(v -> {
            if (GioHang.danhSachGioHang.isEmpty()) {
                Toast.makeText(this, "Giỏ hàng trống", Toast.LENGTH_SHORT).show();
                return;
            }

            DatabaseHelper db = new DatabaseHelper(this);
            int idDonHang = db.themDonHang(GioHang.idBan, GioHang.tinhTongTien());

            for (MonAn m : GioHang.danhSachGioHang) {
                db.themChiTietDonHang(idDonHang, m.getId(), m.getSoLuong());
            }

            // Cập nhật trạng thái bàn → phần 3
            db.capNhatTrangThaiBan(GioHang.idBan, "Đang phục vụ");

            Toast.makeText(this, "Gọi món thành công", Toast.LENGTH_SHORT).show();

            // Xóa giỏ hàng sau khi gọi món
            GioHang.clear();

            // Quay lại chọn bàn
            finish();
        });


        recyclerGioHang = findViewById(R.id.recyclerGioHang);
        txtTongTien = findViewById(R.id.txtTongTien);
        btnThanhToan = findViewById(R.id.btnThanhToan);
        btnQuayLai = findViewById(R.id.btnQuayLai);

        adapter = new GioHangAdapter(GioHang.getDsMonAn(), this, txtTongTien);
        recyclerGioHang.setLayoutManager(new LinearLayoutManager(this));
        recyclerGioHang.setAdapter(adapter);

        txtTongTien.setText("Tổng: " + GioHang.tinhTongTien() + " VNĐ");

        btnThanhToan.setOnClickListener(v ->
                startActivity(new Intent(this, ThanhToanActivity.class))
        );

        btnQuayLai.setOnClickListener(v -> finish());
    }
}
