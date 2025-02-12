-- Create Library Management System database
CREATE DATABASE NumteryLibrary;
USE NumetryLibrary;

-- Authors Table
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(100)
);

-- Books Table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    genre VARCHAR(100),
    publication_year YEAR,
    available_copies INT DEFAULT 1,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

-- Members Table
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    membership_date DATE NOT NULL
);

-- BorrowedBooks Table
CREATE TABLE BorrowedBooks (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE
);



-- Insert

-- Insert authors
INSERT INTO Authors (name, country) VALUES
('J.K. Rowling', 'UK'),
('George R.R. Martin', 'USA'),
('Agatha Christie', 'UK');

-- Insert books
INSERT INTO Books (title, author_id, genre, publication_year, available_copies) VALUES
('Harry Potter and the Sorcerer\'s Stone', 1, 'Fantasy', 1997, 5),
('A Game of Thrones', 2, 'Fantasy', 1996, 3),
('Murder on the Orient Express', 3, 'Mystery', 1934, 4);

-- Insert members
INSERT INTO Members (name, email, phone, membership_date) VALUES
('Alice Johnson', 'alice@example.com', '9876543210', '2023-06-15'),
('Bob Smith', 'bob@example.com', '8765432109', '2024-01-10');


 SQL Queries for Operations
 
1. Add a New Book

INSERT INTO Books (title, author_id, genre, publication_year, available_copies)
VALUES ('The Hobbit', 2, 'Fantasy', 1937, 2);

2. Issue a Book to a Member

-- Check if book is available before issuing

SELECT available_copies FROM Books WHERE book_id = 1;

-- If available, issue the book

INSERT INTO BorrowedBooks (book_id, member_id, borrow_date)
VALUES (1, 1, CURDATE());

-- Decrease the available copies

UPDATE Books SET available_copies = available_copies - 1 WHERE book_id = 1;

3. Return a Book and Update the Database

-- Update the BorrowedBooks table with return date

UPDATE BorrowedBooks
SET return_date = CURDATE()
WHERE book_id = 1 AND member_id = 1 AND return_date IS NULL;

-- Increase the available copies in Books table

UPDATE Books SET available_copies = available_copies + 1 WHERE book_id = 1;
