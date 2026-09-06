-- ==========================================================
-- SCRIPT CƠ SỞ DỮ LIỆU user_db (Cập nhật Bảng Products & OTP)
-- ==========================================================
CREATE DATABASE IF NOT EXISTS user_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE user_db;

-- 1. Bảng lưu trữ thông tin người dùng (users)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NULL DEFAULT 'Người dùng',
    role_id INT NULL DEFAULT 2,
    role VARCHAR(20) NOT NULL DEFAULT 'USER',
    phone VARCHAR(20) NULL,
    email VARCHAR(150) NULL,
    status INT DEFAULT 1,
    otp VARCHAR(10) NULL,
    otp_expiry TIMESTAMP NULL,
    images VARCHAR(255) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Cập nhật bổ sung cột cho bảng users nếu đã tồn tại từ trước
SET @dbname = DATABASE();
SET @tablename = "users";

-- Thêm cột email nếu chưa có
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = @tablename AND table_schema = @dbname AND column_name = 'email') > 0,
  "SELECT 1",
  "ALTER TABLE users ADD COLUMN email VARCHAR(150) NULL;"
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Thêm cột status nếu chưa có
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = @tablename AND table_schema = @dbname AND column_name = 'status') > 0,
  "SELECT 1",
  "ALTER TABLE users ADD COLUMN status INT DEFAULT 1;"
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Thêm cột otp nếu chưa có
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = @tablename AND table_schema = @dbname AND column_name = 'otp') > 0,
  "SELECT 1",
  "ALTER TABLE users ADD COLUMN otp VARCHAR(10) NULL;"
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Thêm cột otp_expiry nếu chưa có
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = @tablename AND table_schema = @dbname AND column_name = 'otp_expiry') > 0,
  "SELECT 1",
  "ALTER TABLE users ADD COLUMN otp_expiry TIMESTAMP NULL;"
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Thêm dữ liệu mẫu tài khoản
INSERT INTO users (username, password, role, role_id, full_name, email, status)
VALUES ('admin', '123456', 'ADMIN', 1, 'Administrator', 'admin@example.com', 1)
ON DUPLICATE KEY UPDATE role = 'ADMIN', role_id = 1, status = 1;

INSERT INTO users (username, password, role, role_id, full_name, email, status)
VALUES ('user1', '123456', 'USER', 2, 'User 1', 'user1@example.com', 1)
ON DUPLICATE KEY UPDATE role = 'USER', role_id = 2, status = 1;

-- 2. Bảng danh mục sản phẩm (category)
CREATE TABLE IF NOT EXISTS category (
    cate_id INT AUTO_INCREMENT PRIMARY KEY,
    cate_name VARCHAR(255) NOT NULL UNIQUE,
    icons VARCHAR(255) NULL
);

INSERT IGNORE INTO category (cate_id, cate_name) VALUES
    (1, 'Điện thoại thông minh'),
    (2, 'Máy tính & Laptop'),
    (3, 'Máy tính bảng'),
    (4, 'Phụ kiện công nghệ');

-- 3. Bảng sản phẩm (products) - Mối quan hệ 1-N với category
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NULL,
    price DOUBLE NOT NULL DEFAULT 0,
    quantity INT NOT NULL DEFAULT 0,
    sold INT NOT NULL DEFAULT 0,
    images VARCHAR(255) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    category_id INT NULL,
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES category(cate_id) ON DELETE SET NULL
);

-- Thêm cột sold nếu chưa có
SET @tablename = "products";
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = @tablename AND table_schema = @dbname AND column_name = 'sold') > 0,
  "SELECT 1",
  "ALTER TABLE products ADD COLUMN sold INT NOT NULL DEFAULT 0;"
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Thêm dữ liệu 15 sản phẩm mẫu (với đầy đủ số lượng tồn kho và số lượng đã bán > 0)
INSERT INTO products (id, name, description, price, quantity, sold, images, category_id) VALUES
    (1, 'iPhone 15 Pro Max', 'Điện thoại flagship cao cấp chip A17 Pro', 34990000, 15, 120, 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=400', 1),
    (2, 'Samsung Galaxy S24 Ultra', 'Điện thoại AI cao cấp màn hình Dynamic AMOLED', 31990000, 20, 95, 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400', 1),
    (3, 'MacBook Pro 14 M3 Pro', 'Laptop đồ họa chuyên nghiệp chip Apple M3 Pro', 49990000, 10, 45, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400', 2),
    (4, 'Dell XPS 15 9530', 'Laptop mỏng nhẹ màn hình OLED 3.5K', 42500000, 8, 30, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=400', 2),
    (5, 'iPad Pro 12.9 M2', 'Máy tính bảng màn hình Mini-LED 120Hz', 28990000, 12, 60, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400', 3),
    (6, 'Tai nghe Sony WH-1000XM5', 'Tai nghe chống ồn chủ động cao cấp', 7990000, 25, 210, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400', 4),
    (7, 'Apple Watch Series 9', 'Đồng hồ thông minh theo dõi sức khỏe', 10490000, 18, 140, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400', 4),
    (8, 'Chuột Logitech MX Master 3S', 'Chuột không dây công sở chống ồn', 2490000, 30, 350, 'https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?w=400', 4),
    (9, 'Bàn phím cơ Keychron K2 V2', 'Bàn phím cơ gõ êm mượt Bluetooth', 1950000, 22, 180, 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=400', 4),
    (10, 'Xiaomi 14 Ultra', 'Điện thoại ống kính Leica chụp ảnh đỉnh cao', 29990000, 14, 85, 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400', 1),
    (11, 'Asus ROG Zephyrus G16', 'Laptop Gaming chip Core Ultra 9 RTX 4070', 54990000, 5, 25, 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=400', 2),
    (12, 'Samsung Galaxy Tab S9 Ultra', 'Máy tính bảng màn hình siêu to 14.6 inch', 26990000, 7, 40, 'https://images.unsplash.com/photo-1561154464-82e9adf32764?w=400', 3),
    (13, 'Loa Bluetooth JBL Charge 5', 'Loa di động âm thanh uy lực chống nước IP67', 3990000, 16, 165, 'https://images.unsplash.com/photo-1545454675-3531b543be5d?w=400', 4),
    (14, 'Màn hình LG UltraGear 27 Inch', 'Màn hình gaming IPS 144Hz 1ms chuyên game', 6490000, 11, 75, 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=400', 2),
    (15, 'AirPods Pro Gen 2 USB-C', 'Tai nghe chống ồn chủ động cao cấp Apple', 5990000, 24, 290, 'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=400', 4)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    description = VALUES(description),
    price = VALUES(price),
    quantity = VALUES(quantity),
    sold = VALUES(sold),
    images = VALUES(images),
    category_id = VALUES(category_id);

SELECT * FROM users;
SELECT * FROM products;