package linh_room.dao;

import linh_room.model.User;

public interface UserDao {

    User get(String username);

    User findById(int id);

    void insert(User user);

    void update(User user);

    boolean checkExistUsername(String username);
}
