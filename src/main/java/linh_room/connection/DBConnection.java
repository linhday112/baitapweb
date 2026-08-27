package linh_room.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.io.InputStream;
import java.util.Properties;

/** MySQL JDBC configuration for the user_db schema. */
public final class DBConnection {

    private static final String URL = System.getProperty("linhroom.jdbc.url",
            "jdbc:mysql://localhost:3306/user_db?useUnicode=true&characterEncoding=UTF-8"
                    + "&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Ho_Chi_Minh");
    private static final String USERNAME = System.getProperty("linhroom.jdbc.user", "root");

    private DBConnection() {
    }

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String password = getPassword();
        if (password == null || password.isBlank()) {
            throw new IllegalStateException(
                    "Thiếu mật khẩu MySQL. Hãy cấu hình biến môi trường LINHROOM_DB_PASSWORD.");
        }
        return DriverManager.getConnection(URL, USERNAME, password);
    }

    private static String getPassword() throws Exception {
        String password = System.getProperty("linhroom.jdbc.password");
        if (password == null || password.isBlank()) {
            password = System.getenv("LINHROOM_DB_PASSWORD");
        }
        if (password == null || password.isBlank()) {
            Properties properties = new Properties();
            try (InputStream input = DBConnection.class.getClassLoader()
                    .getResourceAsStream("database.properties")) {
                if (input != null) {
                    properties.load(input);
                    password = properties.getProperty("db.password");
                }
            }
        }
        return password;
    }
}
