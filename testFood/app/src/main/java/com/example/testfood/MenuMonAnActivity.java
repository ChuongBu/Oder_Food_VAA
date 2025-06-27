package com.example.testfood;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.testfood.Adapter.MonAnAdapter;
import com.example.testfood.SQLite.DatabaseHelper;
import com.example.testfood.model.MonAn;
import com.example.testfood.utils.GioHang;

import java.util.ArrayList;

public class MenuMonAnActivity extends AppCompatActivity implements MonAnAdapter.OnMonClickListener {

    RecyclerView recyclerView;
    ArrayList<MonAn> list;
    MonAnAdapter adapter;
    DatabaseHelper db;
    int idBan;
    Button btnGioHang;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu_monan);

        recyclerView = findViewById(R.id.recyclerMonAnMenu);
        db = new DatabaseHelper(this);

        // Nhận ID bàn được chọn
        idBan = getIntent().getIntExtra("idBan", -1);
        if (idBan == -1) {
            Toast.makeText(this, "Không xác định bàn", Toast.LENGTH_SHORT).show();
            finish();
            return;
        }

        // Khởi tạo giỏ hàng nếu cần
        if (GioHang.idBan != idBan) {
            GioHang.clear(); // xóa giỏ cũ nếu bàn khác
            GioHang.idBan = idBan;
        }

        list = db.getDanhSachMonAn();
        adapter = new MonAnAdapter(this, list, this);

        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setAdapter(adapter);

        btnGioHang = findViewById(R.id.btnGioHang);
        btnGioHang.setOnClickListener(v -> {
            Intent intent = new Intent(this, GioHangActivity.class);
            intent.putExtra("idBan", idBan);
            startActivity(intent);
        });
    }

    @Override
    public void onThemMonClick(MonAn monAn) {
        GioHang.themMon(monAn);
        Toast.makeText(this, monAn.getTen() + " đã được thêm", Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onBackPressed() {
        // Khi nhấn back → quay lại chọn bàn
        super.onBackPressed();
    }
}