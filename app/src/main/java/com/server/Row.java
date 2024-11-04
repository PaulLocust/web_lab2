package com.server;

public class Row {
    private float x;
    private float y;
    private int r;
    private boolean result;

    public Row(float x, float y, int r, boolean result) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.result = result;
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }

    public int getR() {
        return r;
    }

    public boolean getResult() {
        return result;
    }
}
