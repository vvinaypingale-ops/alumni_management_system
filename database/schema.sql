-- Create the database
CREATE DATABASE IF NOT EXISTS alumni_db;
USE alumni_db;

-- Users table (Authentication & Roles)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, -- In a real app, this should be hashed
    role ENUM('ADMIN', 'ALUMNI') DEFAULT 'ALUMNI',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Alumni profile table
CREATE TABLE IF NOT EXISTS alumni (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    graduation_year INT,
    degree VARCHAR(100),
    current_company VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Events table
CREATE TABLE IF NOT EXISTS events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    event_date DATE NOT NULL,
    location VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Messages table
CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    content TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ==============================================
-- SAMPLE DATA
-- ==============================================

-- Insert Sample Users
INSERT INTO users (username, password, role) VALUES 
('admin1', 'adminpass', 'ADMIN'),
('john.doe', 'john123', 'ALUMNI'),
('jane.smith', 'jane123', 'ALUMNI');

-- Insert Sample Alumni Profiles
INSERT INTO alumni (user_id, first_name, last_name, graduation_year, degree, current_company) VALUES 
(2, 'John', 'Doe', 2015, 'B.Tech Computer Science', 'Google'),
(3, 'Jane', 'Smith', 2018, 'M.S. Data Science', 'Amazon');

-- Insert Sample Events
INSERT INTO events (title, description, event_date, location) VALUES 
('Annual Alumni Meet 2026', 'A gathering of all alumni.', '2026-10-15', 'Main University Campus'),
('Tech Talk: Future of AI', 'Guest lecture by distinguished alumni.', '2026-11-20', 'Virtual');

-- Insert Sample Messages
INSERT INTO messages (sender_id, receiver_id, content) VALUES 
(2, 3, 'Hi Jane, are you attending the annual meet?'),
(3, 2, 'Hey John! Yes, I will be there.');


-- ==============================================
-- QUERY EXAMPLES
-- ==============================================

-- JOIN Example: Get all alumni with their usernames
-- SELECT a.first_name, a.last_name, a.graduation_year, u.username, u.role
-- FROM alumni a
-- JOIN users u ON a.user_id = u.id;

-- TRANSACTION Example: Deleting a user and ensuring profile is deleted
-- Note: 'ON DELETE CASCADE' is set, so this is mostly illustrative of how you'd wrap operations.
/*
START TRANSACTION;
    -- Step 1: Delete any specific dependent records if needed before user deletion
    DELETE FROM messages WHERE sender_id = 2 OR receiver_id = 2;
    
    -- Step 2: Delete user (will cascade to alumni table)
    DELETE FROM users WHERE id = 2;
COMMIT;
-- ROLLBACK; -- Use this to undo if something fails
*/
