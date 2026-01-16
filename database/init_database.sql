-- Library Management System Database Initialization Script
-- This script creates tables and inserts sample data for testing

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    full_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    user_type TEXT NOT NULL,
    membership_id TEXT,
    department TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create books table
CREATE TABLE IF NOT EXISTS books (
    book_id INTEGER PRIMARY KEY AUTOINCREMENT,
    isbn TEXT UNIQUE NOT NULL,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    category TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    available_quantity INTEGER NOT NULL,
    publisher TEXT,
    year_published INTEGER,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create borrow records table
CREATE TABLE IF NOT EXISTS borrow_records (
    record_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Insert sample admin user
INSERT INTO users (username, password, full_name, email, user_type, department)
VALUES ('admin', 'admin123', 'System Administrator', 'admin@library.com', 'ADMIN', 'IT Department');

-- Insert sample member user
INSERT INTO users (username, password, full_name, email, user_type, membership_id)
VALUES ('member', 'member123', 'John Doe', 'john.doe@library.com', 'MEMBER', 'MEM2024001');

-- Insert additional members
INSERT INTO users (username, password, full_name, email, user_type, membership_id)
VALUES ('sarah', 'sarah123', 'Sarah Williams', 'sarah.williams@library.com', 'MEMBER', 'MEM2024002');

INSERT INTO users (username, password, full_name, email, user_type, membership_id)
VALUES ('mike', 'mike123', 'Mike Johnson', 'mike.johnson@library.com', 'MEMBER', 'MEM2024003');

-- Insert sample books
INSERT INTO books (isbn, title, author, category, quantity, available_quantity, publisher, year_published)
VALUES 
('978-0134685991', 'Effective Java', 'Joshua Bloch', 'Technology', 5, 5, 'Addison-Wesley', 2018),
('978-0596009205', 'Head First Design Patterns', 'Eric Freeman', 'Technology', 3, 2, 'O''Reilly Media', 2004),
('978-0132350884', 'Clean Code', 'Robert C. Martin', 'Technology', 4, 3, 'Prentice Hall', 2008),
('978-0201633612', 'Design Patterns', 'Gang of Four', 'Technology', 2, 2, 'Addison-Wesley', 1994),
('978-0735619678', 'Code Complete', 'Steve McConnell', 'Technology', 3, 3, 'Microsoft Press', 2004);

INSERT INTO books (isbn, title, author, category, quantity, available_quantity, publisher, year_published)
VALUES 
('978-0062315007', 'The Alchemist', 'Paulo Coelho', 'Fiction', 4, 4, 'HarperOne', 2014),
('978-0061120084', 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 3, 2, 'Harper Perennial', 2006),
('978-0141439518', '1984', 'George Orwell', 'Fiction', 5, 4, 'Penguin Books', 2013),
('978-0743273565', 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 2, 2, 'Scribner', 2004),
('978-0316769174', 'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 3, 3, 'Little, Brown', 2001);

INSERT INTO books (isbn, title, author, category, quantity, available_quantity, publisher, year_published)
VALUES 
('978-0307887894', 'Sapiens', 'Yuval Noah Harari', 'History', 4, 3, 'Harper', 2015),
('978-0385490818', 'The Diary of a Young Girl', 'Anne Frank', 'Biography', 3, 3, 'Bantam', 1993),
('978-1501127625', 'Born a Crime', 'Trevor Noah', 'Biography', 2, 2, 'Spiegel & Grau', 2016),
('978-0143127796', 'Educated', 'Tara Westover', 'Biography', 3, 2, 'Random House', 2018),
('978-0393356687', 'A Brief History of Time', 'Stephen Hawking', 'Science', 2, 2, 'Bantam', 1998);

-- Insert sample borrow records
INSERT INTO borrow_records (user_id, book_id, borrow_date, due_date, status)
VALUES 
(2, 2, '2026-01-01', '2026-01-15', 'BORROWED'),
(2, 7, '2026-01-05', '2026-01-19', 'BORROWED'),
(3, 8, '2025-12-20', '2026-01-03', 'BORROWED');
