import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class InitializeDatabase {
    public static void main(String[] args) {
        String dbPath = "src/main/webapp/WEB-INF/database/library.db";
        String url = "jdbc:sqlite:" + dbPath;
        
        try {
            // Load SQLite JDBC driver
            Class.forName("org.sqlite.JDBC");
            
            System.out.println("Connecting to database: " + dbPath);
            
            try (Connection conn = DriverManager.getConnection(url);
                 Statement stmt = conn.createStatement()) {
                
                // Create users table
                stmt.executeUpdate(
                    "CREATE TABLE IF NOT EXISTS users (" +
                    "user_id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "username TEXT UNIQUE NOT NULL, " +
                    "password TEXT NOT NULL, " +
                    "full_name TEXT NOT NULL, " +
                    "email TEXT UNIQUE NOT NULL, " +
                    "user_type TEXT NOT NULL, " +
                    "membership_id TEXT, " +
                    "department TEXT, " +
                    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP)"
                );
                System.out.println("✓ Created users table");
                
                // Create books table WITH cover_image column
                stmt.executeUpdate(
                    "CREATE TABLE IF NOT EXISTS books (" +
                    "book_id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "isbn TEXT UNIQUE NOT NULL, " +
                    "title TEXT NOT NULL, " +
                    "author TEXT NOT NULL, " +
                    "category TEXT NOT NULL, " +
                    "quantity INTEGER NOT NULL, " +
                    "available_quantity INTEGER NOT NULL, " +
                    "publisher TEXT, " +
                    "year_published INTEGER, " +
                    "cover_image TEXT, " +
                    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP)"
                );
                System.out.println("✓ Created books table (with cover_image column)");
                
                // Create borrow_records table
                stmt.executeUpdate(
                    "CREATE TABLE IF NOT EXISTS borrow_records (" +
                    "record_id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "user_id INTEGER NOT NULL, " +
                    "book_id INTEGER NOT NULL, " +
                    "borrow_date DATE NOT NULL, " +
                    "due_date DATE NOT NULL, " +
                    "return_date DATE, " +
                    "status TEXT NOT NULL, " +
                    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP, " +
                    "FOREIGN KEY (user_id) REFERENCES users(user_id), " +
                    "FOREIGN KEY (book_id) REFERENCES books(book_id))"
                );
                System.out.println("✓ Created borrow_records table");
                
                // Insert sample admin user if not exists
                ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users WHERE username = 'admin'");
                rs.next();
                if (rs.getInt(1) == 0) {
                    stmt.executeUpdate(
                        "INSERT INTO users (username, password, full_name, email, user_type, department) " +
                        "VALUES ('admin', 'admin123', 'System Administrator', 'admin@library.com', 'ADMIN', 'IT Department')"
                    );
                    System.out.println("✓ Added default admin user (username: admin, password: admin123)");
                }
                
                // Insert sample member user if not exists
                rs = stmt.executeQuery("SELECT COUNT(*) FROM users WHERE username = 'member'");
                rs.next();
                if (rs.getInt(1) == 0) {
                    stmt.executeUpdate(
                        "INSERT INTO users (username, password, full_name, email, user_type, membership_id) " +
                        "VALUES ('member', 'member123', 'John Doe', 'john@example.com', 'MEMBER', 'MEM001')"
                    );
                    System.out.println("✓ Added default member user (username: member, password: member123)");
                }
                
                // Insert sample books if table is empty
                rs = stmt.executeQuery("SELECT COUNT(*) FROM books");
                rs.next();
                if (rs.getInt(1) == 0) {
                    String[][] books = {
                        {"978-0134685991", "Effective Java", "Joshua Bloch", "Programming", "10", "10", "Addison-Wesley", "2018", "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400"},
                        {"978-0596009205", "Head First Design Patterns", "Eric Freeman", "Programming", "5", "5", "O'Reilly Media", "2004", "https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400"},
                        {"978-0132350884", "Clean Code", "Robert C. Martin", "Programming", "8", "8", "Prentice Hall", "2008", "https://images.unsplash.com/photo-1589998059171-988d887df646?w=400"}
                    };
                    
                    PreparedStatement pstmt = conn.prepareStatement(
                        "INSERT INTO books (isbn, title, author, category, quantity, available_quantity, publisher, year_published, cover_image) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"
                    );
                    
                    for (String[] book : books) {
                        pstmt.setString(1, book[0]);
                        pstmt.setString(2, book[1]);
                        pstmt.setString(3, book[2]);
                        pstmt.setString(4, book[3]);
                        pstmt.setInt(5, Integer.parseInt(book[4]));
                        pstmt.setInt(6, Integer.parseInt(book[5]));
                        pstmt.setString(7, book[6]);
                        pstmt.setInt(8, Integer.parseInt(book[7]));
                        pstmt.setString(9, book[8]);
                        pstmt.executeUpdate();
                    }
                    pstmt.close();
                    System.out.println("✓ Added 3 sample books with cover images");
                }
                
                System.out.println("\n✓✓✓ Database initialized successfully! ✓✓✓");
                System.out.println("\nYou can now:");
                System.out.println("1. Rebuild the project in IntelliJ (Build → Rebuild Project)");
                System.out.println("2. Restart Tomcat");
                System.out.println("3. Login with admin/admin123 or member/member123");
                
            }
        } catch (Exception e) {
            System.err.println("ERROR: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
