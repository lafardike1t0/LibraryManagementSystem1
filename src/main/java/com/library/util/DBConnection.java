package com.library.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// Singleton pattern for database connection
public class DBConnection {
    
    // Single instance variable (Singleton)
    private static DBConnection instance;
    private Connection connection;
    
    // Database URL - will be set dynamically
    private static String DB_URL;
    
    // Private constructor to prevent instantiation
    private DBConnection() {
        try {
            // Explicitly load SQLite JDBC driver
            Class.forName("org.sqlite.JDBC");
            
            // Determine database path based on environment
            String dbPath = getDatabasePath();
            DB_URL = "jdbc:sqlite:" + dbPath;
            
            System.out.println("Attempting to connect to database at: " + dbPath);
            
            // Create connection
            connection = DriverManager.getConnection(DB_URL);
            System.out.println("Database connection established successfully");
            
            // Initialize database tables if they don't exist
            initializeDatabase();
        } catch (ClassNotFoundException e) {
            System.err.println("SQLite JDBC Driver not found: " + e.getMessage());
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Database connection error: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // Determine the correct database path for different deployment scenarios
    private String getDatabasePath() {
        // Try multiple paths in order of preference
        
        // Path 1: For development/exploded WAR in IntelliJ (most common for development)
        String path1 = "src/main/webapp/WEB-INF/database/library.db";
        if (new java.io.File(path1).exists()) {
            System.out.println("Using development path: " + path1);
            return path1;
        }
        
        // Path 2: Relative to project root
        String path2 = "database/library.db";
        if (new java.io.File(path2).exists()) {
            System.out.println("Using project root path: " + path2);
            return path2;
        }
        
        // Path 3: For regular Tomcat deployment
        String catalinaBase = System.getProperty("catalina.base");
        if (catalinaBase != null) {
            String path3 = catalinaBase + "/webapps/LibraryManagementSystem/WEB-INF/database/library.db";
            if (new java.io.File(path3).exists()) {
                System.out.println("Using Tomcat deployment path: " + path3);
                return path3;
            }
            
            // Path 4: For exploded deployment
            String path4 = catalinaBase + "/webapps/LibraryManagementSystem_war_exploded/WEB-INF/database/library.db";
            if (new java.io.File(path4).exists()) {
                System.out.println("Using Tomcat exploded path: " + path4);
                return path4;
            }
        }
        
        // Path 5: Create in temp directory as fallback
        String tempPath = System.getProperty("java.io.tmpdir") + "/library.db";
        System.out.println("Database not found, creating in temp directory: " + tempPath);
        return tempPath;
    }
    
    // Thread-safe method to get single instance
    public static synchronized DBConnection getInstance() {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }
    
    // Get database connection
    public Connection getConnection() {
        try {
            // Check if connection is closed and reopen if necessary
            if (connection == null || connection.isClosed()) {
                connection = DriverManager.getConnection(DB_URL);
            }
        } catch (SQLException e) {
            System.err.println("Error getting connection: " + e.getMessage());
            e.printStackTrace();
        }
        return connection;
    }
    
    // Initialize database tables
    private void initializeDatabase() {
        try (Statement stmt = connection.createStatement()) {
            
            // Create users table
            String createUsersTable = "CREATE TABLE IF NOT EXISTS users (" +
                    "user_id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "username TEXT UNIQUE NOT NULL, " +
                    "password TEXT NOT NULL, " +
                    "full_name TEXT NOT NULL, " +
                    "email TEXT UNIQUE NOT NULL, " +
                    "user_type TEXT NOT NULL, " +
                    "membership_id TEXT, " +
                    "department TEXT, " +
                    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP)";
            stmt.execute(createUsersTable);
            
            // Create books table
            String createBooksTable = "CREATE TABLE IF NOT EXISTS books (" +
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
                    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP)";
            stmt.execute(createBooksTable);
            
            // Add cover_image column if it doesn't exist (for existing databases)
            try {
                ResultSet rs = stmt.executeQuery("PRAGMA table_info(books)");
                boolean hasCoverImage = false;
                while (rs.next()) {
                    if ("cover_image".equals(rs.getString("name"))) {
                        hasCoverImage = true;
                        break;
                    }
                }
                if (!hasCoverImage) {
                    stmt.execute("ALTER TABLE books ADD COLUMN cover_image TEXT");
                    System.out.println("Added cover_image column to books table");
                }
            } catch (SQLException e) {
                // Column might already exist or other error
                if (!e.getMessage().contains("duplicate column")) {
                    System.err.println("Warning: Could not add cover_image column: " + e.getMessage());
                }
            }
            
            // Create borrow records table
            String createBorrowTable = "CREATE TABLE IF NOT EXISTS borrow_records (" +
                    "record_id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "user_id INTEGER NOT NULL, " +
                    "book_id INTEGER NOT NULL, " +
                    "borrow_date DATE NOT NULL, " +
                    "due_date DATE NOT NULL, " +
                    "return_date DATE, " +
                    "status TEXT NOT NULL, " +
                    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP, " +
                    "FOREIGN KEY (user_id) REFERENCES users(user_id), " +
                    "FOREIGN KEY (book_id) REFERENCES books(book_id))";
            stmt.execute(createBorrowTable);
            
            System.out.println("Database tables initialized successfully");
            
            // Insert sample data if tables are empty
            insertSampleData();
            
        } catch (SQLException e) {
            System.err.println("Error initializing database: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // Insert sample data for testing
    private void insertSampleData() {
        try (Statement stmt = connection.createStatement()) {
            // Check if users table is empty
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users");
            if (rs.next() && rs.getInt(1) == 0) {
                System.out.println("Inserting sample data...");
                
                // Insert sample admin user
                stmt.execute("INSERT INTO users (username, password, full_name, email, user_type, department) " +
                        "VALUES ('admin', 'admin123', 'System Administrator', 'admin@library.com', 'ADMIN', 'IT Department')");
                
                // Insert sample member users
                stmt.execute("INSERT INTO users (username, password, full_name, email, user_type, membership_id) " +
                        "VALUES ('member', 'member123', 'John Doe', 'john.doe@library.com', 'MEMBER', 'MEM2024001')");
                
                stmt.execute("INSERT INTO users (username, password, full_name, email, user_type, membership_id) " +
                        "VALUES ('sarah', 'sarah123', 'Sarah Williams', 'sarah.williams@library.com', 'MEMBER', 'MEM2024002')");
                
                stmt.execute("INSERT INTO users (username, password, full_name, email, user_type, membership_id) " +
                        "VALUES ('mike', 'mike123', 'Mike Johnson', 'mike.johnson@library.com', 'MEMBER', 'MEM2024003')");
                
                // Insert sample books
                stmt.execute("INSERT INTO books (isbn, title, author, category, quantity, available_quantity, publisher, year_published) " +
                        "VALUES ('978-0134685991', 'Effective Java', 'Joshua Bloch', 'Technology', 5, 5, 'Addison-Wesley', 2018)");
                
                stmt.execute("INSERT INTO books (isbn, title, author, category, quantity, available_quantity, publisher, year_published) " +
                        "VALUES ('978-0596009205', 'Head First Design Patterns', 'Eric Freeman', 'Technology', 3, 2, 'O''Reilly Media', 2004)");
                
                stmt.execute("INSERT INTO books (isbn, title, author, category, quantity, available_quantity, publisher, year_published) " +
                        "VALUES ('978-0132350884', 'Clean Code', 'Robert C. Martin', 'Technology', 4, 3, 'Prentice Hall', 2008)");
                
                stmt.execute("INSERT INTO books (isbn, title, author, category, quantity, available_quantity, publisher, year_published) " +
                        "VALUES ('978-0201633612', 'Design Patterns', 'Gang of Four', 'Technology', 2, 2, 'Addison-Wesley', 1994)");
                
                stmt.execute("INSERT INTO books (isbn, title, author, category, quantity, available_quantity, publisher, year_published) " +
                        "VALUES ('978-0735619678', 'Code Complete', 'Steve McConnell', 'Technology', 3, 3, 'Microsoft Press', 2004)");
                
                stmt.execute("INSERT INTO books (isbn, title, author, category, quantity, available_quantity, publisher, year_published) " +
                        "VALUES ('978-0062315007', 'The Alchemist', 'Paulo Coelho', 'Fiction', 4, 4, 'HarperOne', 2014)");
                
                stmt.execute("INSERT INTO books (isbn, title, author, category, quantity, available_quantity, publisher, year_published) " +
                        "VALUES ('978-0061120084', 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 3, 2, 'Harper Perennial', 2006)");
                
                stmt.execute("INSERT INTO books (isbn, title, author, category, quantity, available_quantity, publisher, year_published) " +
                        "VALUES ('978-0141439518', '1984', 'George Orwell', 'Fiction', 5, 4, 'Penguin Books', 2013)");
                
                stmt.execute("INSERT INTO books (isbn, title, author, category, quantity, available_quantity, publisher, year_published) " +
                        "VALUES ('978-0307887894', 'Sapiens', 'Yuval Noah Harari', 'History', 4, 3, 'Harper', 2015)");
                
                stmt.execute("INSERT INTO books (isbn, title, author, category, quantity, available_quantity, publisher, year_published) " +
                        "VALUES ('978-0385490818', 'The Diary of a Young Girl', 'Anne Frank', 'Biography', 3, 3, 'Bantam', 1993)");
                
                // Insert sample borrow records
                stmt.execute("INSERT INTO borrow_records (user_id, book_id, borrow_date, due_date, status) " +
                        "VALUES (2, 2, '2026-01-01', '2026-01-15', 'BORROWED')");
                
                stmt.execute("INSERT INTO borrow_records (user_id, book_id, borrow_date, due_date, status) " +
                        "VALUES (2, 7, '2026-01-05', '2026-01-19', 'BORROWED')");
                
                stmt.execute("INSERT INTO borrow_records (user_id, book_id, borrow_date, due_date, status) " +
                        "VALUES (3, 8, '2025-12-20', '2026-01-03', 'BORROWED')");
                
                System.out.println("Sample data inserted successfully");
            } else {
                System.out.println("Database already contains data, skipping sample data insertion");
            }
        } catch (SQLException e) {
            System.err.println("Error inserting sample data: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // Close database connection
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Database connection closed");
            }
        } catch (SQLException e) {
            System.err.println("Error closing connection: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
