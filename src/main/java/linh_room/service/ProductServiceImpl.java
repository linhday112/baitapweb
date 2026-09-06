package linh_room.service;

import java.util.List;
import linh_room.dao.ProductDao;
import linh_room.dao.ProductDaoImpl;
import linh_room.model.Product;

public class ProductServiceImpl implements ProductService {

    private final ProductDao productDao = new ProductDaoImpl();

    @Override
    public List<Product> getAll() {
        return productDao.getAll();
    }

    @Override
    public List<Product> findTop10Newest() {
        return productDao.findTop10Newest();
    }

    @Override
    public List<Product> findTop10Sold() {
        return productDao.findTop10Sold();
    }

    @Override
    public List<Product> findPaginated(int page, int pageSize) {
        return productDao.findPaginated(page, pageSize);
    }

    @Override
    public List<Product> findPaginatedSorted(int page, int pageSize, String sortBy) {
        return productDao.findPaginatedSorted(page, pageSize, sortBy);
    }

    @Override
    public int countAll() {
        return productDao.countAll();
    }

    @Override
    public Product get(int id) {
        return productDao.findById(id);
    }

    @Override
    public void insert(Product product) {
        productDao.insert(product);
    }

    @Override
    public void update(Product product) {
        productDao.update(product);
    }

    @Override
    public void delete(int id) {
        productDao.delete(id);
    }

    @Override
    public List<Product> search(String keyword) {
        return productDao.search(keyword);
    }
}