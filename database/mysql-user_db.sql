-- ==========================================================
-- SCRIPT CƠ SỞ DỮ LIỆU user_db (Khớp với MySQL Workbench)
-- ==========================================================
CREATE DATABASE IF NOT EXISTS user_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE user_db;

-- 1. Bảng lưu trữ thông tin đăng nhập (users)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NULL DEFAULT 'Người dùng',
    role_id INT NULL DEFAULT 2,
    role VARCHAR(20) NOT NULL DEFAULT 'USER',
    phone VARCHAR(20) NULL,
    images VARCHAR(255) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Cập nhật bổ sung cột nếu bảng đã tồn tại từ phiên bản cũ
SET @dbname = DATABASE();
SET @tablename = "users";

-- Thêm cột role nếu chưa có
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = @tablename AND table_schema = @dbname AND column_name = 'role') > 0,
  "SELECT 1",
  "ALTER TABLE users ADD COLUMN role VARCHAR(20) NOT NULL DEFAULT 'USER';"
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Thêm cột phone nếu chưa có
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = @tablename AND table_schema = @dbname AND column_name = 'phone') > 0,
  "SELECT 1",
  "ALTER TABLE users ADD COLUMN phone VARCHAR(20) NULL;"
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Thêm cột images nếu chưa có
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = @tablename AND table_schema = @dbname AND column_name = 'images') > 0,
  "SELECT 1",
  "ALTER TABLE users ADD COLUMN images VARCHAR(255) NULL;"
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Thêm cột created_at nếu chưa có
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = @tablename AND table_schema = @dbname AND column_name = 'created_at') > 0,
  "SELECT 1",
  "ALTER TABLE users ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;"
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- 2. Thêm dữ liệu mẫu tài khoản (Dùng INSERT IGNORE / ON DUPLICATE KEY UPDATE)
INSERT INTO users (username, password, role, role_id, full_name)
VALUES ('admin', '123456', 'ADMIN', 1, 'Administrator')
ON DUPLICATE KEY UPDATE role = 'ADMIN', role_id = 1;

INSERT INTO users (username, password, role, role_id, full_name)
VALUES ('user1', '123456', 'USER', 2, 'User 1')
ON DUPLICATE KEY UPDATE role = 'USER', role_id = 2;

-- 3. Bảng danh mục sản phẩm (category)
CREATE TABLE IF NOT EXISTS category (
    cate_id INT AUTO_INCREMENT PRIMARY KEY,
    cate_name VARCHAR(255) NOT NULL UNIQUE,
    icons VARCHAR(255) NULL
);

INSERT IGNORE INTO category (cate_id, cate_name, icons) VALUES
    (1, 'Điện thoại thông minh', 'https://cdn-icons-png.flaticon.com/512/0/191.png'),
    (2, 'Máy tính & Laptop', 'https://cdn-icons-png.flaticon.com/512/428/428001.png'),
    (3, 'Máy tính bảng', 'https://cdn-icons-png.flaticon.com/512/689/689396.png'),
    (4, 'Phụ kiện công nghệ', 'https://cdn-icons-png.flaticon.com/512/833/833314.png');

-- Hiển thị danh sách tất cả tài khoản
SELECT * FROM users;