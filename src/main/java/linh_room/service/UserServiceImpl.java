package linh_room.service;

import java.util.List;
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

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public boolean generateAndSendOTP(User user, String subject, String bodyHeader) {
        if (user == null) return false;
        String otp = String.format("%06d", new java.security.SecureRandom().nextInt(900000) + 100000);
        java.util.Date expiry = new java.util.Date(System.currentTimeMillis() + 10 * 60 * 1000);
        String recipient = user.getEmail() == null ? "" : user.getEmail().trim();
        if (recipient.isBlank()) {
            System.err.println("Không thể gửi OTP: tài khoản " + user.getUsername() + " chưa có email.");
            return false;
        }

        String htmlBody = "<h3>" + bodyHeader + "</h3>"
                + "<p>Xin chào <strong>" + user.getFullName() + "</strong>,</p>"
                + "<p>Mã OTP xác thực của bạn là: <b style='font-size: 22px; color: #1a73e8;'>" + otp + "</b></p>"
                + "<p>Mã OTP này có hiệu lực trong vòng 10 phút. Vui lòng không chia sẻ mã này cho ai.</p>";

        // Chỉ xác nhận thành công sau khi Gmail đã chấp nhận email.
        if (!linh_room.util.EmailUtil.sendEmail(recipient, subject, htmlBody)) {
            return false;
        }

        user.setOtp(otp);
        user.setOtpExpiry(expiry);
        userDao.update(user);
        return true;
    }

    @Override
    public boolean verifyOTP(String username, String otp) {
        User user = get(username);
        if (user == null || user.getOtp() == null || otp == null) {
            return false;
        }
        if (!user.getOtp().trim().equals(otp.trim())) {
            return false;
        }
        if (user.getOtpExpiry() != null && user.getOtpExpiry().before(new java.util.Date())) {
            return false;
        }
        user.setStatus(1);
        user.setOtp(null);
        user.setOtpExpiry(null);
        userDao.update(user);
        return true;
    }

    @Override
    public boolean resetPasswordWithOTP(String username, String otp, String newPassword) {
        User user = get(username);
        if (user == null || user.getOtp() == null || otp == null || newPassword == null || newPassword.isBlank()) {
            return false;
        }
        if (!user.getOtp().trim().equals(otp.trim())) {
            return false;
        }
        if (user.getOtpExpiry() != null && user.getOtpExpiry().before(new java.util.Date())) {
            return false;
        }
        user.setPassword(newPassword.trim());
        user.setOtp(null);
        user.setOtpExpiry(null);
        userDao.update(user);
        return true;
    }

    @Override
    public List<User> getAllUsers() {
        return userDao.getAll();
    }

    @Override
    public boolean deleteUser(int id) {
        User user = userDao.findById(id);
        if (user == null) {
            return false;
        }
        // Bảo vệ không cho phép xóa tài khoản Admin hệ thống
        if ("ADMIN".equalsIgnoreCase(user.getRole()) || user.getRoleId() == 1) {
            return false;
        }
        userDao.delete(id);
        return true;
    }
}