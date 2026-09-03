package linh_room.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import linh_room.configs.JPAConfig;
import linh_room.model.User;

public class UserDaoImpl implements UserDao {

    @Override
    public User get(String username) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<User> query = em.createNamedQuery("User.findByUsername", User.class);
            query.setParameter("username", username);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } catch (Exception exception) {
            throw new IllegalStateException("Không thể truy vấn người dùng.", exception);
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(User user) {
        EntityManager em = JPAConfig.getEntityManager();
        jakarta.persistence.EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw new IllegalStateException("Không thể lưu thông tin người dùng vào cơ sở dữ liệu.", e);
        } finally {
            em.close();
        }
    }

    @Override
    public boolean checkExistUsername(String username) {
        return get(username) != null;
    }

    @Override
    public User findById(int id) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.find(User.class, id);
        } catch (Exception e) {
            throw new IllegalStateException("Không thể tìm người dùng theo ID.", e);
        } finally {
            em.close();
        }
    }

    @Override
    public void update(User user) {
        EntityManager em = JPAConfig.getEntityManager();
        jakarta.persistence.EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw new IllegalStateException("Không thể cập nhật thông tin người dùng.", e);
        } finally {
            em.close();
        }
    }
}
