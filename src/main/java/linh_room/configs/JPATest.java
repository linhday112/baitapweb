package linh_room.configs;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import linh_room.model.Category;
import linh_room.model.Product;

public class JPATest {

    public static void main(String[] args) {
        System.out.println("====== BẮT ĐẦU ĐỒNG BỘ 15 SẢN PHẨM VÀ SỐ LƯỢNG ĐÃ BÁN VÀO DATABASE ======");
        EntityManager em = null;
        try {
            em = JPAConfig.getEntityManager();
            EntityTransaction trans = em.getTransaction();
            trans.begin();

            Category cat1 = em.find(Category.class, 1);
            Category cat2 = em.find(Category.class, 2);
            Category cat3 = em.find(Category.class, 3);
            Category cat4 = em.find(Category.class, 4);

            Object[][] data = {
                {1, "iPhone 15 Pro Max", "Điện thoại flagship cao cấp chip A17 Pro", 34990000.0, 15, 120, "https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=400", cat1},
                {2, "Samsung Galaxy S24 Ultra", "Điện thoại AI cao cấp màn hình Dynamic AMOLED", 31990000.0, 20, 95, "https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400", cat1},
                {3, "MacBook Pro 14 M3 Pro", "Laptop đồ họa chuyên nghiệp chip Apple M3 Pro", 49990000.0, 10, 45, "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400", cat2},
                {4, "Dell XPS 15 9530", "Laptop mỏng nhẹ màn hình OLED 3.5K", 42500000.0, 8, 30, "https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=400", cat2},
                {5, "iPad Pro 12.9 M2", "Máy tính bảng màn hình Mini-LED 120Hz", 28990000.0, 12, 60, "https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400", cat3},
                {6, "Tai nghe Sony WH-1000XM5", "Tai nghe chống ồn chủ động cao cấp", 7990000.0, 25, 210, "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400", cat4},
                {7, "Apple Watch Series 9", "Đồng hồ thông minh theo dõi sức khỏe", 10490000.0, 18, 140, "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400", cat4},
                {8, "Chuột Logitech MX Master 3S", "Chuột không dây công sở chống ồn", 2490000.0, 30, 350, "https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?w=400", cat4},
                {9, "Bàn phím cơ Keychron K2 V2", "Bàn phím cơ gõ êm mượt Bluetooth", 1950000.0, 22, 180, "https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=400", cat4},
                {10, "Xiaomi 14 Ultra", "Điện thoại ống kính Leica chụp ảnh đỉnh cao", 29990000.0, 14, 85, "https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400", cat1},
                {11, "Asus ROG Zephyrus G16", "Laptop Gaming chip Core Ultra 9 RTX 4070", 54990000.0, 5, 25, "https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400", cat2},
                {12, "Samsung Galaxy Tab S9 Ultra", "Máy tính bảng màn hình siêu to 14.6 inch", 26990000.0, 7, 40, "https://images.unsplash.com/photo-1561154464-82e9adf32764?w=400", cat3},
                {13, "Loa Bluetooth JBL Charge 5", "Loa di động âm thanh uy lực chống nước IP67", 3990000.0, 16, 165, "https://images.unsplash.com/photo-1545454675-3531b543be5d?w=400", cat4},
                {14, "Màn hình LG UltraGear 27 Inch", "Màn hình gaming IPS 144Hz 1ms chuyên game", 6490000.0, 11, 75, "https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=400", cat2},
                {15, "AirPods Pro Gen 2 USB-C", "Tai nghe chống ồn chủ động cao cấp Apple", 5990000.0, 24, 290, "https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=400", cat4}
            };

            for (Object[] row : data) {
                int id = (Integer) row[0];
                Product p = em.find(Product.class, id);
                if (p == null) {
                    p = new Product();
                }
                p.setName((String) row[1]);
                p.setDescription((String) row[2]);
                p.setPrice((Double) row[3]);
                p.setQuantity((Integer) row[4]);
                p.setSold((Integer) row[5]);
                p.setImages((String) row[6]);
                if (row[7] != null) {
                    p.setCategory((Category) row[7]);
                }
                em.merge(p);
            }

            trans.commit();
            System.out.println("[OK] ĐÃ ĐỒNG BỘ THÀNH CÔNG 15 SẢN PHẨM VÀ SỐ LƯỢNG ĐÃ BÁN VÀO DATABASE!");

            List<Product> products = em.createNamedQuery("Product.findAllOrderBySold", Product.class).getResultList();
            System.out.println("=== DANH SÁCH " + products.size() + " SẢN PHẨM SAU KHI ĐỒNG BỘ ===");
            for (Product p : products) {
                System.out.println(" - ID: " + p.getId() + " | Tên: " + p.getName() + " | Tồn kho: " + p.getQuantity() + " | Đã bán: " + p.getSold());
            }
        } catch (Exception e) {
            System.err.println("[ERROR] Lỗi đồng bộ dữ liệu:");
            e.printStackTrace();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
            JPAConfig.close();
        }
    }
}
