-- CSD430 database creation and sample data
-- WARNING: Running user-creation statements requires MySQL root (administrator) privileges.
-- Edit or remove CREATE USER / GRANT statements if running on a managed host where you cannot create users.

-- Create database
CREATE DATABASE IF NOT EXISTS `CSD430` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `CSD430`;

-- Create user and grant privileges (requires root)
-- If your MySQL version doesn't support IF NOT EXISTS for CREATE USER, run the CREATE USER line only when necessary.
CREATE USER IF NOT EXISTS 'student1'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON `CSD430`.* TO 'student1'@'localhost';
FLUSH PRIVILEGES;

-- Drop table if you want to re-run (commented out by default)
-- DROP TABLE IF EXISTS `Amanda_movies_data`;

-- Create table: Amanda_movies_data
CREATE TABLE IF NOT EXISTS `Amanda_movies_data` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `genre` VARCHAR(50) NOT NULL,
  `year` INT NOT NULL,
  `director` VARCHAR(100),
  `rating` DECIMAL(3,1),
  `notes` TEXT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample records (10 records)
INSERT INTO `Amanda_movies_data` (title, genre, year, director, rating, notes) VALUES
('The Shawshank Redemption','Drama',1994,'Frank Darabont',9.3,'Prison drama based on Stephen King short story.'),
('The Godfather','Crime',1972,'Francis Ford Coppola',9.2,'Mafia epic adapted from Mario Puzo novel.'),
('Pulp Fiction','Crime',1994,'Quentin Tarantino',8.9,'Interwoven stories, nonlinear narrative.'),
('Inception','Sci-Fi',2010,'Christopher Nolan',8.8,'Mind-bending heist inside dreams.'),
('The Matrix','Sci-Fi',1999,'Lana Wachowski & Lilly Wachowski',8.7,'Reality-bending action sci-fi.'),
('Spirited Away','Animation',2001,'Hayao Miyazaki',8.6,'Studio Ghibli fantasy adventure.'),
('Parasite','Thriller',2019,'Bong Joon Ho',8.6,'Social satire, Academy Award winner.'),
('The Dark Knight','Action',2008,'Christopher Nolan',9.0,'Superhero film with iconic Joker.'),
('Forrest Gump','Drama',1994,'Robert Zemeckis',8.8,'Life story through decades of American history.'),
('The Grand Budapest Hotel','Comedy',2014,'Wes Anderson',8.1,'Stylized comedy with ensemble cast.');

-- End of script

-- To re-run from scratch uncomment the DROP TABLE and/or DROP DATABASE lines above as needed.
