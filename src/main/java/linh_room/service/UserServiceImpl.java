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
}
