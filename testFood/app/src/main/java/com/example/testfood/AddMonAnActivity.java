package com.example.testfood;

import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;
import com.example.testfood.SQLite.DatabaseHelper;
import com.example.testfood.model.MonAn;

public class AddMonAnActivity extends AppCompatActivity {

    EditText edtTen, edtGia, edtHinh;
    Button btnThem;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_mon);

        edtTen = findViewById(R.id.edtTenMon);
        edtGia = findViewById(R.id.edtGiaMon);
        edtHinh = findViewById(R.id.edtHinhMon);
        btnThem = findViewById(R.id.btnThemMon);

        btnThem.setOnClickListener(v -> {
            String ten = edtTen.getText().toString();
            String hinh = edtHinh.getText().toString();
            int gia = Integer.parseInt(edtGia.getText().toString());

            MonAn mon = new MonAn(0, ten, gia, hinh);
            DatabaseHelper db = DatabaseHelper.getInstance(this);
            db.themMonAn(mon);

            Toast.makeText(this, "Đã thêm món!", Toast.LENGTH_SHORT).show();
            finish();
        });
    }
}
