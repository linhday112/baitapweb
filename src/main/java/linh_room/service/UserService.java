package linh_room.service;

import linh_room.model.User;

public interface UserService {

    User login(String username, String password);

    User get(String username);

    boolean register(User user);

    boolean checkExistUsername(String username);

    User findById(int id);

    User findByEmail(String email);

    void update(User user);

    boolean updateProfile(int userId, String fullName, String phone, String images);

    boolean generateAndSendOTP(User user, String subject, String bodyHeader);

    boolean verifyOTP(String username, String otp);

    boolean resetPasswordWithOTP(String username, String otp, String newPassword);

    java.util.List<User> getAllUsers();

    boolean deleteUser(int id);
}
