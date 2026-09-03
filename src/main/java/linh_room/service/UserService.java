package linh_room.service;

import linh_room.model.User;

public interface UserService {

    User login(String username, String password);

    User get(String username);

    boolean register(User user);

    boolean checkExistUsername(String username);

    User findById(int id);

    void update(User user);

    boolean updateProfile(int userId, String fullName, String phone, String images);
}
