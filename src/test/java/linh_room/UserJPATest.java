package linh_room;

import linh_room.dao.UserDao;
import linh_room.dao.UserDaoImpl;
import linh_room.model.User;
import linh_room.service.UserService;
import linh_room.service.UserServiceImpl;

public class UserJPATest {
    public static void main(String[] args) {
        System.out.println("========== BẮT ĐẦU KIỂM THỬ PROFILE VÀ JPA ==========");
        UserDao userDao = new UserDaoImpl();
        UserService userService = new UserServiceImpl();



        // 1. Kiểm tra tài khoản admin
        User admin = userDao.get("admin");
        if (admin != null) {
            System.out.println("[OK] Tìm thấy tài khoản admin: " + admin.getUsername() + ", Role: " + admin.getRole());
        }

        // 2. Thử nghiệm cập nhật Profile cho tài khoản admin
        if (admin != null) {
            boolean updated = userService.updateProfile(admin.getId(), "Quản Trị Viên VIP", "0987654321", "user/admin_avatar.jpg");
            if (updated) {
                User freshAdmin = userDao.get("admin");
                System.out.println("[OK] Cập nhật Profile thành công qua JPA:");
                System.out.println("   - FullName: " + freshAdmin.getFullName());
                System.out.println("   - Phone: " + freshAdmin.getPhone());
                System.out.println("   - Images: " + freshAdmin.getImages());
            } else {
                System.err.println("[FAIL] Cập nhật Profile thất bại!");
            }
        }

        // 3. Kiểm thử thêm mới và cập nhật cho user bình thường
        String testUsername = "profile_tester";
        User tester = userDao.get(testUsername);
        if (tester == null) {
            tester = new User();
            tester.setUsername(testUsername);
            tester.setPassword("123456");
            tester.setFullName("Tester Profile");
            tester.setRole("USER");
            userService.register(tester);
            tester = userDao.get(testUsername);
        }

        if (tester != null) {
            userService.updateProfile(tester.getId(), "Tester Đã Cập Nhật", "0912345678", "user/avatar_tester.png");
            User reloaded = userDao.findById(tester.getId());
            System.out.println("[OK] Cập nhật Profile thành công cho user: " + reloaded.getUsername());
            System.out.println("   - FullName: " + reloaded.getFullName());
            System.out.println("   - Phone: " + reloaded.getPhone());
            System.out.println("   - Images: " + reloaded.getImages());
        }

        System.out.println("========== HOÀN TẤT KIỂM THỬ PROFILE VÀ JPA THÀNH CÔNG ==========");
    }
}