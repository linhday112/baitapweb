package linh_room.util;

import java.io.InputStream;
import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    private static String getSmtpHost() {
        return getProperty("mail.smtp.host", "MAIL_SMTP_HOST", "smtp.gmail.com");
    }

    private static String getSmtpPort() {
        return getProperty("mail.smtp.port", "MAIL_SMTP_PORT", "587");
    }

    private static String getSenderEmail() {
        return getProperty("mail.sender.email", "MAIL_SENDER_EMAIL", "linhroom.noreply@gmail.com");
    }

    private static String getSenderPassword() {
        return getProperty("mail.sender.password", "MAIL_SENDER_PASSWORD", "app_password_here");
    }

    private static String getProperty(String sysProp, String envVar, String defaultValue) {
        String val = System.getProperty(sysProp);
        if (val != null && !val.isBlank()) return val.trim();

        val = System.getenv(envVar);
        if (val != null && !val.isBlank()) return val.trim();

        try (InputStream input = EmailUtil.class.getClassLoader().getResourceAsStream("database.properties")) {
            if (input != null) {
                Properties prop = new Properties();
                prop.load(input);
                val = prop.getProperty(sysProp);
                if (val != null && !val.isBlank()) return val.trim();
            }
        } catch (Exception ignored) {
        }

        return defaultValue;
    }

    public static boolean sendEmail(String recipientEmail, String subject, String bodyContent) {
        String host = getSmtpHost();
        String port = getSmtpPort();
        String senderEmail = getSenderEmail();
        String senderPassword = getSenderPassword();

        System.out.println("=================================================");
        System.out.println("[EMAIL SERVICE] Đang gửi email thực tế qua Gmail SMTP...");
        System.out.println("[EMAIL SERVICE] Người gửi: " + senderEmail);
        System.out.println("[EMAIL SERVICE] Người nhận: " + recipientEmail);
        System.out.println("[EMAIL SERVICE] Tiêu đề: " + subject);
        System.out.println("=================================================");

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", host);
        props.put("mail.smtp.connectiontimeout", "10000");
        props.put("mail.smtp.timeout", "10000");
        props.put("mail.smtp.writetimeout", "10000");

        try {
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmail, senderPassword);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail, "Linh Room Web"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail, true));
            message.setSubject(subject);
            message.setContent(bodyContent, "text/html; charset=UTF-8");

            // Thực hiện gửi email thực tế qua SMTP
            Transport.send(message);
            System.out.println("[EMAIL SUCCESS] ĐÃ GỬI EMAIL THÀNH CÔNG TỚI GMAIL: " + recipientEmail);
            return true;
        } catch (Exception e) {
            System.err.println("[EMAIL ERROR] Không thể gửi email thực tế qua SMTP!");
            System.err.println("[EMAIL ERROR] Chi tiết lỗi: " + e.getMessage());
            if (e.getMessage() != null && e.getMessage().contains("535")) {
                System.err.println("[EMAIL ERROR] => Lỗi xác thực (535 Bad Credentials): Email hoặc Mật khẩu ứng dụng Gmail (App Password) trong database.properties không đúng!");
                System.err.println("[EMAIL ERROR] => Hướng dẫn: Vui lòng vào https://myaccount.google.com/apppasswords để tạo Mật khẩu ứng dụng 16 ký tự và nhập vào file database.properties.");
            }
            return false;
        }
    }
}