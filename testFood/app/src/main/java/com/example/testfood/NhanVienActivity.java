package com.example.testfood;

import android.content.Intent;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.testfood.Adapter.BanAdapter;
import com.example.testfood.SQLite.DatabaseHelper;
import com.example.testfood.model.BanAn;

import java.util.ArrayList;

public class NhanVienActivity extends AppCompatActivity {

    RecyclerView recyclerView;
    BanAdapter banAdapter;
    ArrayList<BanAn> listBan;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_nhanvien);

        recyclerView = findViewById(R.id.recyclerBan);

        DatabaseHelper dbHelper = new DatabaseHelper(this);
        listBan = dbHelper.getDanhSachBan();


        banAdapter = new BanAdapter(this, listBan, new BanAdapter.OnBanClickListener() {
            @Override
            public void onBanClick(BanAn ban) {
                Intent intent = new Intent(NhanVienActivity.this, MenuMonAnActivity.class);
                intent.putExtra("idBan", ban.getId());
                startActivity(intent);
            }
        });

        recyclerView.setLayoutManager(new GridLayoutManager(this, 2));
        recyclerView.setAdapter(banAdapter);
    }}

