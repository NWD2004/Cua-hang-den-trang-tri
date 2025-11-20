package Model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GioHang {
    private Map<String, GioHangItem> items; // Key: maDen_maMau_maKichThuoc

    public GioHang() {
        this.items = new HashMap<>();
    }

    // Thêm sản phẩm vào giỏ hàng
    public void addItem(GioHangItem item) {
        String key = item.getKey();
        if (items.containsKey(key)) {
            // Nếu đã có, tăng số lượng
            GioHangItem existingItem = items.get(key);
            existingItem.setSoLuong(existingItem.getSoLuong() + item.getSoLuong());
        } else {
            // Nếu chưa có, thêm mới
            items.put(key, item);
        }
    }

    // Cập nhật số lượng
    public void updateQuantity(String key, int quantity) {
        if (items.containsKey(key)) {
            if (quantity <= 0) {
                items.remove(key);
            } else {
                items.get(key).setSoLuong(quantity);
            }
        }
    }

    // Xóa item
    public void removeItem(String key) {
        items.remove(key);
    }

    // Xóa tất cả
    public void clear() {
        items.clear();
    }

    // Lấy danh sách items
    public List<GioHangItem> getItems() {
        return new ArrayList<>(items.values());
    }

    // Lấy item theo key
    public GioHangItem getItem(String key) {
        return items.get(key);
    }

    // Đếm tổng số sản phẩm
    public int getTotalItems() {
        int total = 0;
        for (GioHangItem item : items.values()) {
            total += item.getSoLuong();
        }
        return total;
    }

    // Tính tổng tiền
    public double getTotalPrice() {
        double total = 0;
        for (GioHangItem item : items.values()) {
            total += item.getTongTien();
        }
        return total;
    }

    // Kiểm tra giỏ hàng có rỗng không
    public boolean isEmpty() {
        return items.isEmpty();
    }

    // Lấy số lượng item khác nhau (không tính số lượng mỗi item)
    public int getItemCount() {
        return items.size();
    }
}

