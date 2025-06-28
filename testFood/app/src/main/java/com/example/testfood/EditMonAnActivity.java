package com.example.testfood;

import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;
import com.example.testfood.SQLite.DatabaseHelper;
import com.example.testfood.model.MonAn;

public class EditMonAnActivity extends AppCompatActivity {

    EditText edtTen, edtGia, edtHinh;
    Button btnCapNhat, btnXoa;
    MonAn monAn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_mon);

        edtTen = findViewById(R.id.edtTenMon);
        edtGia = findViewById(R.id.edtGiaMon);
        edtHinh = findViewById(R.id.edtHinhMon);
        btnCapNhat = findViewById(R.id.btnCapNhatMon);
        btnXoa = findViewById(R.id.btnXoaMon);

        monAn = (MonAn) getIntent().getSerializableExtra("mon");

        if (monAn != null) {
            edtTen.setText(monAn.getTen());
            edtGia.setText(String.valueOf(monAn.getGia()));
            edtHinh.setText(monAn.getHinhAnh());
        }

        DatabaseHelper db = DatabaseHelper.getInstance(this);


        btnCapNhat.setOnClickListener(v -> {
            monAn.setTen(edtTen.getText().toString());
            monAn.setGia(Integer.parseInt(edtGia.getText().toString()));
            monAn.setHinhAnh(edtHinh.getText().toString());

            db.capNhatMonAn(monAn);
            Toast.makeText(this, "Đã cập nhật!", Toast.LENGTH_SHORT).show();
            finish();
        });

        btnXoa.setOnClickListener(v -> {
            db.xoaMonAn(monAn.getId());
            Toast.makeText(this, "Đã xoá món!", Toast.LENGTH_SHORT).show();
            finish();
        });
    }
}
