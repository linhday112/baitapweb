package linh_room.dao;

import linh_room.model.User;

public interface UserDao {

    User get(String username);
}
