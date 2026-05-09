import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class TestDB {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://ep-fragrant-sound-aq8ch43r-pooler.c-8.us-east-1.aws.neon.tech/neondb?sslmode=require";
        String user = "neondb_owner";
        String pwd = "npg_eo2Ckivh0jaL";

        try {
            Connection con = DriverManager.getConnection(url, user, pwd);
            System.out.println("Connected to Neon DB!");
            
            // Check what's in the DB
            PreparedStatement ps1 = con.prepareStatement("SELECT * FROM users");
            ResultSet rs1 = ps1.executeQuery();
            while(rs1.next()) {
                System.out.println("User: " + rs1.getString("username") + ", Password: " + rs1.getString("password"));
            }
            
            // Check login
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE username = ? AND password = crypt(?, password)");
            ps.setString(1, "admin");
            ps.setString(2, "admin123");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println("Login Success: " + rs.getString("role"));
            } else {
                System.out.println("Login Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
