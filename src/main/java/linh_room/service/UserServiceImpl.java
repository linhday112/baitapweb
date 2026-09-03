package linh_room.service;

import linh_room.dao.UserDao;
import linh_room.dao.UserDaoImpl;
import linh_room.model.User;

public class UserServiceImpl implements UserService {

    private final UserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        User user = get(username);

        if (user != null && user.getPassword().equals(password)) {
            return user;
        }

        return null;
    }

    @Override
    public User get(String username) {
        return userDao.get(username);
    }

    @Override
    public boolean register(User user) {
        if (user == null || user.getUsername() == null || user.getUsername().isBlank()) {
            return false;
        }
        if (checkExistUsername(user.getUsername())) {
            return false;
        }
        if (user.getRole() == null || user.getRole().isBlank()) {
            user.setRole("USER");
        }
        if (user.getFullName() == null || user.getFullName().isBlank()) {
            user.setFullName(user.getUsername());
        }
        if (user.getRoleId() == 0) {
            user.setRoleId("ADMIN".equalsIgnoreCase(user.getRole()) ? 1 : 2);
        }
        userDao.insert(user);
        return true;
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public boolean updateProfile(int userId, String fullName, String phone, String images) {
        User user = findById(userId);
        if (user == null) {
            return false;
        }
        if (fullName != null && !fullName.isBlank()) {
            user.setFullName(fullName.trim());
        }
        user.setPhone(phone != null ? phone.trim() : null);
        if (images != null && !images.isBlank()) {
            user.setImages(images.trim());
        }
        update(user);
        return true;
    }
}
