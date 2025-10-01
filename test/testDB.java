import util.DBUtil;
import java.sql.Connection;

public class testDB {
    public static void main(String[] args) {
        try (Connection conn = DBUtil.getConnection()) {
            if (conn != null) {
                System.out.println("✅ Kết nối MySQL thành công!");
            } else {
                System.out.println("❌ Kết nối thất bại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
