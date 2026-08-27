package linh_room.service;

import java.util.List;

import linh_room.dao.CategoryDao;
import linh_room.dao.CategoryDaoImpl;
import linh_room.model.Category;

public class CategoryServiceImpl implements CategoryService {

    private final CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public void insert(Category category) {
        validate(category);
        categoryDao.insert(category);
    }

    @Override
    public void update(Category category) {
        validate(category);
        if (categoryDao.get(category.getId()) == null) {
            throw new IllegalArgumentException("Danh mục không tồn tại để cập nhật.");
        }
        categoryDao.update(category);
    }

    @Override
    public void delete(int id) {
        categoryDao.delete(id);
    }

    @Override
    public Category get(int id) {
        return categoryDao.get(id);
    }

    @Override
    public List<Category> getAll() {
        return categoryDao.getAll();
    }

    @Override
    public List<Category> search(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return categoryDao.getAll();
        }
        return categoryDao.search(keyword.trim());
    }

    @Override
    public int count() {
        return categoryDao.count();
    }

    @Override
    public List<Category> findAll(int page, int pageSize) {
        if (page < 1) page = 1;
        if (pageSize < 1) pageSize = 10;
        return categoryDao.findAll(page, pageSize);
    }

    private void validate(Category category) {
        if (category == null) {
            throw new IllegalArgumentException("Dữ liệu danh mục không được để trống.");
        }
        if (category.getName() == null || category.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Tên danh mục không được để trống.");
        }
    }
}
