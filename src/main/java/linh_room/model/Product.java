package linh_room.model;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

@Entity
@Table(name = "products")
@NamedQueries({
    @NamedQuery(name = "Product.findAll", query = "SELECT p FROM Product p ORDER BY p.id DESC"),
    @NamedQuery(name = "Product.findTop10Newest", query = "SELECT p FROM Product p ORDER BY p.createdAt DESC, p.id DESC"),
    @NamedQuery(name = "Product.findTop10Sold", query = "SELECT p FROM Product p ORDER BY p.sold DESC, p.id DESC"),
    @NamedQuery(name = "Product.findAllOrderBySold", query = "SELECT p FROM Product p ORDER BY p.sold DESC, p.id DESC"),
    @NamedQuery(name = "Product.countAll", query = "SELECT COUNT(p) FROM Product p")
})
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "name", length = 255, nullable = false)
    private String name;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "price")
    private Double price = 0.0;

    @Column(name = "quantity")
    private Integer quantity = 0;

    @Column(name = "sold")
    private Integer sold = 0;

    @Column(name = "images", length = 255)
    private String images;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at", insertable = true, updatable = false)
    private Date createdAt;

    @jakarta.persistence.PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = new Date();
        }
    }

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    public Product() {
    }

    public Product(int id, String name, double price, int quantity, int sold, String images, Category category) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.sold = sold;
        this.images = images;
        this.category = category;
    }

    public Product(int id, String name, double price, int quantity, String images, Category category) {
        this(id, name, price, quantity, 0, images, category);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price != null ? price : 0.0;
    }

    public void setPrice(Double price) {
        this.price = price != null ? price : 0.0;
    }

    public int getQuantity() {
        return quantity != null ? quantity : 0;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity != null ? quantity : 0;
    }

    public int getSold() {
        return sold != null ? sold : 0;
    }

    public void setSold(Integer sold) {
        this.sold = sold != null ? sold : 0;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getImageUrl(String contextPath) {
        if (images != null && !images.isBlank()) {
            if (images.startsWith("http://") || images.startsWith("https://")) {
                return images;
            }
            String base = (contextPath == null || contextPath.isEmpty()) ? "" : contextPath;
            return base + "/image?fname=" + images;
        }
        return "https://via.placeholder.com/300x200?text=No+Image";
    }
}