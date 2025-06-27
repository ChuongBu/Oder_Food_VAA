package com.example.testfood;

import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.testfood.Adapter.MonAnAdapter;
import com.example.testfood.SQLite.DatabaseHelper;
import com.example.testfood.model.MonAn;

import java.util.ArrayList;

public class QuanLyMonAnActivity extends AppCompatActivity {

    RecyclerView recyclerView;
    ArrayList<MonAn> list;
     MonAnAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_quanlymonan);

        recyclerView = findViewById(R.id.recyclerMonAn);
        DatabaseHelper dbHelper = new DatabaseHelper(this);
        list = dbHelper.getDanhSachMonAn();

        adapter = new MonAnAdapter(this, list, this);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setAdapter(adapter);
    }
}
