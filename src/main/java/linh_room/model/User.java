package linh_room.model;

import java.io.Serializable;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

@Entity
@Table(name = "users")
@NamedQuery(name = "User.findByUsername", query = "SELECT u FROM User u WHERE u.username = :username")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "username", length = 50, nullable = false, unique = true)
    private String username;

    @Column(name = "password", length = 255, nullable = false)
    private String password;

    @Column(name = "full_name", length = 100)
    private String fullName;

    @Column(name = "role_id")
    private Integer roleId = 2;

    @Column(name = "role", length = 20, nullable = false)
    private String role = "USER";

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "email", length = 150)
    private String email;

    @Column(name = "status")
    private Integer status = 1; // 1: Active, 0: Pending OTP activation

    @Column(name = "otp", length = 10)
    private String otp;

    @jakarta.persistence.Temporal(jakarta.persistence.TemporalType.TIMESTAMP)
    @Column(name = "otp_expiry")
    private java.util.Date otpExpiry;

    @Column(name = "images", length = 255)
    private String images;

    @jakarta.persistence.Temporal(jakarta.persistence.TemporalType.TIMESTAMP)
    @Column(name = "created_at", insertable = false, updatable = false)
    private java.util.Date createdAt;

    public User() {
    }

    public User(int id, String username, String password, String role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.role = role != null ? role : "USER";
        this.fullName = username;
        this.roleId = "ADMIN".equalsIgnoreCase(this.role) ? 1 : 2;
    }

    public User(int id, String username, String password, String fullName, int roleId) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.roleId = roleId;
        this.role = (roleId == 1) ? "ADMIN" : "USER";
    }

    public User(int id, String username, String password, String fullName, Integer roleId, String role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.roleId = roleId;
        this.role = role != null ? role : "USER";
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        if (fullName != null && !fullName.isBlank()) {
            return fullName;
        }
        return username;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public int getRoleId() {
        if (roleId != null) {
            return roleId;
        }
        return "ADMIN".equalsIgnoreCase(role) ? 1 : 2;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getRole() {
        if (role != null && !role.isBlank()) {
            return role;
        }
        return (roleId != null && roleId == 1) ? "ADMIN" : "USER";
    }

    public void setRole(String role) {
        this.role = role;
    }

    public java.util.Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(java.util.Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getStatus() {
        return status != null ? status : 1;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }

    public java.util.Date getOtpExpiry() {
        return otpExpiry;
    }

    public void setOtpExpiry(java.util.Date otpExpiry) {
        this.otpExpiry = otpExpiry;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public String getAvatarUrl(String contextPath) {
        if (images != null && !images.isBlank()) {
            if (images.startsWith("http://") || images.startsWith("https://")) {
                return images;
            }
            String base = (contextPath == null || contextPath.isEmpty()) ? "" : contextPath;
            return base + "/image?fname=" + images;
        }
        return "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";
    }

    public boolean isAdmin() {
        if (role != null && !role.isBlank()) {
            return "ADMIN".equalsIgnoreCase(role.trim());
        }
        return roleId != null && roleId == 1;
    }
}
