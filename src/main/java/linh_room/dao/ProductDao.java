package linh_room.dao;

import java.util.List;
import linh_room.model.Product;

public interface ProductDao {
    List<Product> getAll();
    List<Product> findTop10Newest();
    List<Product> findTop10Sold();
    List<Product> findPaginated(int page, int pageSize);
    List<Product> findPaginatedSorted(int page, int pageSize, String sortBy);
    int countAll();
    Product findById(int id);
    void insert(Product product);
    void update(Product product);
    void delete(int id);
    List<Product> search(String keyword);
}