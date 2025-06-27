package com.example.testfood.Adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.testfood.MenuMonAnActivity;
import com.example.testfood.R;
import com.example.testfood.model.MonAn;
import com.example.testfood.utils.GioHang;

import java.util.ArrayList;

public class MonAnAdapter extends RecyclerView.Adapter<MonAnAdapter.MonAnViewHolder> {

    Context context;
    ArrayList<MonAn> list;

    public MonAnAdapter(Context context, ArrayList<MonAn> list, MenuMonAnActivity menuMonAnActivity) {
        this.context = context;
        this.list = list;
    }

    @NonNull
    @Override
    public MonAnViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        return new MonAnViewHolder(LayoutInflater.from(context).inflate(R.layout.item_monan, parent, false));
    }

    @Override
    public void onBindViewHolder(@NonNull MonAnViewHolder holder, int position) {
        MonAn monAn = list.get(position);
        holder.txtTen.setText(monAn.getTen());
        holder.txtGia.setText(monAn.getGia() + " VNĐ");

        holder.btnThem.setOnClickListener(v -> {
            GioHang.themMonAn(monAn); // static class quản lý giỏ hàng
            Toast.makeText(context, "Đã thêm " + monAn.getTen(), Toast.LENGTH_SHORT).show();
        });
    }

    @Override
    public int getItemCount() {
        return list.size();
    }

    public interface OnMonClickListener {
        void onThemMonClick(MonAn monAn);
    }

    public static class MonAnViewHolder extends RecyclerView.ViewHolder {
        TextView txtTen, txtGia;
        Button btnThem;

        public MonAnViewHolder(@NonNull View itemView) {
            super(itemView);
            txtTen = itemView.findViewById(R.id.txtTen);
            txtGia = itemView.findViewById(R.id.txtGia);
            btnThem = itemView.findViewById(R.id.btnThem);
        }
    }
}
