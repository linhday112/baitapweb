package linh_room.service;

import java.util.List;
import linh_room.model.Category;

public interface CategoryService {

    void insert(Category category);

    void update(Category category);

    void delete(int id);

    Category get(int id);

    List<Category> getAll();

    List<Category> search(String keyword);

    int count();

    List<Category> findAll(int page, int pageSize);
}
