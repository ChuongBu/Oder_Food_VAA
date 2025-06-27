package com.example.testfood.model;

public class BanAn {
    private int id;
    private int soBan;
    private String trangThai;

    public BanAn(int id, int soBan, String trangThai) {
        this.id = id;
        this.soBan = soBan;
        this.trangThai = trangThai;
    }

    public int getId() { return id; }
    public int getSoBan() { return soBan; }
    public String getTrangThai() { return trangThai; }

    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
}
