package com.example.testfood;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.example.testfood.SQLite.DatabaseHelper;

public class LoginActivity extends AppCompatActivity {

    EditText edtUser, edtPass;
    Button btnLogin;
    DatabaseHelper dbHelper;

    @SuppressLint("MissingInflatedId")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        edtUser = findViewById(R.id.edtUsername);
        edtPass = findViewById(R.id.edtPassword);
        btnLogin = findViewById(R.id.btnLogin);

        dbHelper = new DatabaseHelper(this);

        btnLogin.setOnClickListener(v -> {
            String user = edtUser.getText().toString();
            String pass = edtPass.getText().toString();

            SQLiteDatabase db = dbHelper.getReadableDatabase();
            Cursor cursor = db.rawQuery("SELECT * FROM User WHERE username=? AND password=?", new String[]{user, pass});
            if (cursor.moveToFirst()) {
                String role = cursor.getString(cursor.getColumnIndexOrThrow("role"));
                Toast.makeText(this, "Đăng nhập thành công", Toast.LENGTH_SHORT).show();

                if (role.equals("admin")) {
                    startActivity(new Intent(this, AdminActivity.class));
                } else {
                    startActivity(new Intent(this, NhanVienActivity.class));
                }
            } else {
                Toast.makeText(this, "Sai tài khoản hoặc mật khẩu", Toast.LENGTH_SHORT).show();
            }
            cursor.close();
        });
    }
}