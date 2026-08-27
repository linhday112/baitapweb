package linh_room.configs;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import linh_room.model.Category;

public class JPATest {

    public static void main(String[] args) {
        System.out.println("====== BẮT ĐẦU KIỂM THỬ CẤU HÌNH VÀ KẾT NỐI JPA ======");
        EntityManager em = null;
        try {
            em = JPAConfig.getEntityManager();
            System.out.println("[OK] Đã khởi tạo EntityManager thành công từ persistence-unit 'dataSource'!");

            EntityTransaction trans = em.getTransaction();
            trans.begin();

            // Thêm 1 category thử nghiệm bằng JPA
            Category testCate = new Category();
            testCate.setName("JPA Test Category " + System.currentTimeMillis());
            testCate.setIcon("https://via.placeholder.com/80?text=JPA");
            
            em.persist(testCate);
            trans.commit();
            System.out.println("[OK] Thêm thành công Category bằng JPA. Generated ID = " + testCate.getId());

            // Truy vấn lại danh sách category bằng JPA
            List<Category> list = em.createNamedQuery("Category.findAll", Category.class).getResultList();
            System.out.println("[OK] Số lượng danh mục hiện tại trong DB: " + list.size());
            for (Category c : list) {
                System.out.println(" - ID: " + c.getId() + " | Tên: " + c.getName() + " | Icon: " + c.getIcon());
            }

            System.out.println("====== KIỂM THỬ JPA HOÀN TẤT THÀNH CÔNG ======");
        } catch (Exception e) {
            System.err.println("[ERROR] Lỗi kiểm thử JPA:");
            e.printStackTrace();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
            JPAConfig.close();
        }
    }
}
