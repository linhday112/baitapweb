package linh_room.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import linh_room.configs.JPAConfig;
import linh_room.model.Category;

public class CategoryDaoImpl implements CategoryDao {

    @Override
    public void insert(Category category) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(category);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw new IllegalStateException("Lỗi khi thêm danh mục bằng JPA: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Category category) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(category);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw new IllegalStateException("Lỗi khi cập nhật danh mục bằng JPA: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int id) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Category category = em.find(Category.class, id);
            if (category != null) {
                em.remove(category);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw new IllegalStateException("Lỗi khi xóa danh mục bằng JPA: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public Category get(int id) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.find(Category.class, id);
        } catch (Exception e) {
            throw new IllegalStateException("Lỗi khi tìm danh mục theo id: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category> getAll() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Category> query = em.createNamedQuery("Category.findAll", Category.class);
            return query.getResultList();
        } catch (Exception e) {
            throw new IllegalStateException("Lỗi khi lấy danh sách danh mục: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category> search(String keyword) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT c FROM Category c WHERE LOWER(c.name) LIKE LOWER(:keyword) ORDER BY c.id ASC";
            TypedQuery<Category> query = em.createQuery(jpql, Category.class);
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
        } catch (Exception e) {
            throw new IllegalStateException("Lỗi khi tìm kiếm danh mục: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public int count() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT COUNT(c) FROM Category c";
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            return query.getSingleResult().intValue();
        } catch (Exception e) {
            throw new IllegalStateException("Lỗi khi đếm danh mục: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category> findAll(int page, int pageSize) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Category> query = em.createNamedQuery("Category.findAll", Category.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } catch (Exception e) {
            throw new IllegalStateException("Lỗi khi phân trang danh mục: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }
}
