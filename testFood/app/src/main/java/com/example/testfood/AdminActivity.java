package com.example.testfood;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;

public class AdminActivity extends AppCompatActivity {

    Button btnMonAn, btnNhanVien, btnDonHang;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_admin);

        btnMonAn = findViewById(R.id.btnMonAn);
        btnNhanVien = findViewById(R.id.btnNhanVien);
        btnDonHang = findViewById(R.id.btnDonHang);

        btnMonAn.setOnClickListener(v -> startActivity(new Intent(this, QuanLyMonAnActivity.class)));
        btnNhanVien.setOnClickListener(v -> startActivity(new Intent(this, QuanLyNhanVienActivity.class)));
        btnDonHang.setOnClickListener(v -> startActivity(new Intent(this, XemDonHangActivity.class)));
    }
}