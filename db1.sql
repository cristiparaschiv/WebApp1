-- Database Creation
CREATE DATABASE mydb;
USE mydb;
-- Table Script Creation
CREATE TABLE artists(
   id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(50),
   description TEXT,
   date_founded DATE,
   country VARCHAR(40),
   picture VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE genres(
   id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(50),
   description TEXT
) ENGINE=InnoDB;

CREATE TABLE tracks(
   id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(50),
   albumid INT,
   artistid INT,
   playtime TIME,
   lyrics TEXT,
   summary TEXT,
   recommended TINYINT(1)
) ENGINE=InnoDB;

CREATE TABLE albums(
   id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(50),
   artistid INT,
   release_date DATE,
   summary TEXT,
   playtime TIME,
   genreid INT,
   picture VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE pictures(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    type VARCHAR(20),
    filename VARCHAR(50)
) ENGINE=InnoDB;
-- Relationships Creation
ALTER TABLE albums ADD CONSTRAINT artists_albums_CON FOREIGN KEY(artistid) REFERENCES artists (id);
ALTER TABLE tracks ADD CONSTRAINT artists_tracks_CON FOREIGN KEY(artistid) REFERENCES artists (id);
ALTER TABLE tracks ADD CONSTRAINT albums_tracks_CON FOREIGN KEY(albumid) REFERENCES albums (id);
ALTER TABLE albums ADD CONSTRAINT genres_albums_CON FOREIGN KEY(genreid) REFERENCES genres (id);