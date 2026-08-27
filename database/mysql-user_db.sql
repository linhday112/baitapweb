CREATE DATABASE IF NOT EXISTS user_db
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE user_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL DEFAULT 'Administrator',
    role_id INT NOT NULL DEFAULT 1
);

-- Chỉ chạy hai lệnh ALTER sau nếu bảng users đã tồn tại nhưng thiếu cột.
-- ALTER TABLE users ADD COLUMN full_name VARCHAR(100) NOT NULL DEFAULT 'Administrator';
-- ALTER TABLE users ADD COLUMN role_id INT NOT NULL DEFAULT 1;
UPDATE users SET full_name = 'Administrator', role_id = 1 WHERE username = 'admin';

CREATE TABLE IF NOT EXISTS category (
    cate_id INT AUTO_INCREMENT PRIMARY KEY,
    cate_name VARCHAR(255) NOT NULL UNIQUE,
    icons VARCHAR(255) NULL
);

INSERT IGNORE INTO category (cate_name, icons) VALUES
    ('Điện thoại', 'https://via.placeholder.com/80?text=Phone'),
    ('Máy tính', 'https://via.placeholder.com/80?text=PC');
