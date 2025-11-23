-- Module-6: Create and populate table used by JavaBean/JSP assignment
-- WARNING: CREATE USER / GRANT require administrative privileges. Remove or edit those lines if you don't have root access.

CREATE DATABASE IF NOT EXISTS `CSD430` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `CSD430`;

-- (Optional) Create a student user for Java access. Comment out if not allowed in your environment.
CREATE USER IF NOT EXISTS 'student1'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON `CSD430`.* TO 'student1'@'localhost';
FLUSH PRIVILEGES;

-- Table used by the Module-6 JavaBean demo
DROP TABLE IF EXISTS `Amanda_movies_data`;
CREATE TABLE `Amanda_movies_data` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `genre` VARCHAR(50) NOT NULL,
  `year` INT NOT NULL,
  `director` VARCHAR(100),
  `rating` DECIMAL(3,1),
  `notes` TEXT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Sample rows (10)
INSERT INTO `Amanda_movies_data` (title, genre, year, director, rating, notes) VALUES
('The Shawshank Redemption','Drama',1994,'Frank Darabont',9.3,'Prison drama.'),
('The Godfather','Crime',1972,'Francis Ford Coppola',9.2,'Mafia classic.'),
('Pulp Fiction','Crime',1994,'Quentin Tarantino',8.9,'Interwoven stories.'),
('Inception','Sci-Fi',2010,'Christopher Nolan',8.8,'Dream heist.'),
('The Matrix','Sci-Fi',1999,'Lana Wachowski & Lilly Wachowski',8.7,'Reality-bending.'),
('Spirited Away','Animation',2001,'Hayao Miyazaki',8.6,'Fantasy.'),
('Parasite','Thriller',2019,'Bong Joon Ho',8.6,'Social satire.'),
('The Dark Knight','Action',2008,'Christopher Nolan',9.0,'Batman & Joker.'),
('Forrest Gump','Drama',1994,'Robert Zemeckis',8.8,'Life story.'),
('The Grand Budapest Hotel','Comedy',2014,'Wes Anderson',8.1,'Stylized comedy.');

-- End of script
