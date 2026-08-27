package linh_room;

import linh_room.dao.UserDao;
import linh_room.dao.UserDaoImpl;
import linh_room.model.User;

public class UserJPATest {
    public static void main(String[] args) {
        UserDao userDao = new UserDaoImpl();
        User admin = userDao.get("admin");
        if (admin != null) {
            System.out.println("[USER JPA OK] Tìm thấy user: username=" + admin.getUsername() + ", FullName=" + admin.getFullName() + ", RoleId=" + admin.getRoleId());
        } else {
            System.out.println("[USER JPA WARNING] Không tìm thấy user 'admin' trong DB.");
        }
    }
}