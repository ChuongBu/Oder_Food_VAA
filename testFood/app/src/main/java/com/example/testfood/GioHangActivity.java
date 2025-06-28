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
    int idBan;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_giohang);

        recyclerGioHang = findViewById(R.id.recyclerGioHang);
        txtTongTien = findViewById(R.id.txtTongTien);
        btnThanhToan = findViewById(R.id.btnThanhToan);
        btnQuayLai = findViewById(R.id.btnQuayLai);
        btnGoiMon = findViewById(R.id.btnGoiMon);

        // Lấy ID bàn từ intent
        idBan = getIntent().getIntExtra("idBan", -1);
        if (idBan == -1) {
            Toast.makeText(this, "Không xác định được bàn!", Toast.LENGTH_SHORT).show();
            finish();
            return;
        }

        // Đảm bảo giỏ hàng đúng với bàn đang phục vụ
        if (GioHang.idBan != idBan) {
            GioHang.idBan = idBan;
        }

        adapter = new GioHangAdapter(GioHang.getDanhSachGioHang(), this, txtTongTien);
        recyclerGioHang.setLayoutManager(new LinearLayoutManager(this));
        recyclerGioHang.setAdapter(adapter);

        txtTongTien.setText("Tổng: " + GioHang.tinhTongTien() + " VNĐ");

        btnThanhToan.setOnClickListener(v -> {
            Intent intent = new Intent(this, ThanhToanActivity.class);
            intent.putExtra("idBan", idBan);
            startActivity(intent);
        });

        btnQuayLai.setOnClickListener(v -> finish());

        btnGoiMon.setOnClickListener(v -> {
            if (GioHang.getDanhSachGioHang().isEmpty()) {
                Toast.makeText(this, "Giỏ hàng trống", Toast.LENGTH_SHORT).show();
                return;
            }

            btnGoiMon.setEnabled(false);

            DatabaseHelper db = DatabaseHelper.getInstance(this);
            int idDonHang = db.themDonHang(GioHang.idBan, GioHang.tinhTongTien());
            for (MonAn m : GioHang.getDanhSachGioHang()) {
                db.themChiTietDonHang(idDonHang, m.getId(), m.getSoLuong());
            }

            db.capNhatTrangThaiBan(GioHang.idBan, "Đang phục vụ");
            Toast.makeText(this, "Gọi món thành công", Toast.LENGTH_SHORT).show();

            GioHang.clear(); // 👉 Không reset idBan bên trong

            // Quay về màn danh sách bàn (nhân viên)
            Intent intent = new Intent(this, NhanVienActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
            finish();
        });
    }
}
