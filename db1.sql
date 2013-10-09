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

CREATE TABLE tools(
	id INT PRIMARY KEY AUTO_INCREMENT,
	menuname VARCHAR(50),
	`path` VARCHAR(100),
	controller VARCHAR(50),
	action VARCHAR (50),
	`order` INT
) ENGINE=InnoDB;
-- Relationships Creation
ALTER TABLE albums ADD CONSTRAINT artists_albums_CON FOREIGN KEY(artistid) REFERENCES artists (id);
ALTER TABLE tracks ADD CONSTRAINT artists_tracks_CON FOREIGN KEY(artistid) REFERENCES artists (id);
ALTER TABLE tracks ADD CONSTRAINT albums_tracks_CON FOREIGN KEY(albumid) REFERENCES albums (id);
ALTER TABLE albums ADD CONSTRAINT genres_albums_CON FOREIGN KEY(genreid) REFERENCES genres (id);

-- Populate tables
-- Tools
    -- Admin
INSERT INTO tools VALUES (
    NULL,
    'Add User',
    'Administration/Users',
    'user',
    'add',
    1
);
INSERT INTO tools VALUES (
    NULL,
    'Browse User',
    'Administration/Users',
    'user',
    'view',
    1
);
    -- Config
INSERT INTO tools VALUES (
	NULL,
	'Add Genre',
	'Configuration/Genres',
	'genre',
	'add',
	1
);
INSERT INTO tools VALUES (
	NULL,
	'Browse Genres',
	'Configuration/Genres',
	'genre',
	'view',
	1
);
INSERT INTO tools VALUES (
	NULL,
	'Add Track',
	'Configuration/Tracks',
	'track',
	'add',
	1
);
INSERT INTO tools VALUES (
	NULL,
	'Browse Tracks',
	'Configuration/Tracks',
	'track',
	'view',
	1
);    
INSERT INTO tools VALUES (
	NULL,
	'Add Albums',
	'Configuration/Albums',
	'album',
	'add',
	1
);
INSERT INTO tools VALUES (
	NULL,
	'Browse Albums',
	'Configuration/Albums',
	'album',
	'view',
	1
);
INSERT INTO tools VALUES (
	NULL,
	'Add Artist',
	'Configuration/Artists',
	'artist',
	'add',
	1
);
INSERT INTO tools VALUES (
	NULL,
	'Browse Artists',
	'Configuration/Artists',
	'artist',
	'view',
	1
);

-- Objects
INSERT INTO artists VALUES (
	NULL,
	'King Crimson',
	'Prog rock band',
	'1969-01-01',
	'United Kingdom',
	''
);
INSERT INTO genres VALUES (
	NULL,
	'Progressive Rock',
	'Prog Rock summary'
);
INSERT INTO albums VALUES (
	NULL,
	'Red',
	1,
	'1971-01-01',
	'Summary',
	'45:00',
	1,
	''
);