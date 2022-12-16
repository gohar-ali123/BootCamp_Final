--DDL Database creation
--CREATE DATABASE DB_LibraryManagementSystem;


--DDL Books table creation
CREATE TABLE Books (
	BookId int PRIMARY KEY NOT NULL IDENTITY(1,1),
	BookName varchar(100) NOT NULL,
	Category varchar(100) NOT NULL,
	Author varchar(100) NOT NULL,
	ShelfNumber int NOT NULL,
	Price float NOT NULL,
	Issued varchar(100) NOT NULL DEFAULT 'no'
);

SELECT * FROM Books;

--DML Inserting books into Books table
INSERT INTO Books VALUES ('A Game of Thrones', 'Epic fantasy', 'R R Martin', 1, 12.5, 'yes');
INSERT INTO Books VALUES ('A Clash of Kings', 'Epic fantasy', 'R R Martin', 1, 10, 'no');
INSERT INTO Books VALUES ('A Storm of Swords', 'Epic fantasy', 'R R Martin', 1, 14, 'yes');
INSERT INTO Books VALUES ('A Feast for Crows', 'Epic fantasy', 'R R Martin', 1, 13.2, 'yes');
INSERT INTO Books VALUES ('A Dance with Dragons', 'Epic fantasy', 'R R Martin', 1, 14.5, 'yes');
INSERT INTO Books VALUES ('The Winds of Winter', 'Epic fantasy', 'R R Martin', 2, 11, 'yes');
INSERT INTO Books VALUES ('A Dream of Spring', 'Epic fantasy', 'R R Martin', 2, 15, 'yes');
INSERT INTO Books VALUES ('Dearly devoted Dexter', 'Crime horror', 'Jeff Lindsay', 2, 8, 'yes');
INSERT INTO Books VALUES ('Dexter in the Dark', 'Crime horror', 'Jeff Lindsay', 2, 8.5, 'yes');
INSERT INTO Books VALUES ('Dexter by Design', 'Crime horror', 'Jeff Lindsay', 2, 10, 'yes');
INSERT INTO Books VALUES ('Dexter is Delicious', 'Crime horror', 'Jeff Lindsay', 3, 9, 'yes');
INSERT INTO Books VALUES ('Double Dexter', 'Crime horror', 'Jeff Lindsay', 3, 11, 'yes');
INSERT INTO Books VALUES ('Dexter Final Cut', 'Crime horror', 'Jeff Lindsay', 3, 9, 'yes');
INSERT INTO Books VALUES ('Dexter is Dead', 'Crime horror', 'Jeff Lindsay', 3, 12.5, 'yes');
INSERT INTO Books VALUES ('The Empty House', 'Crime Mystery', 'Conan Doyle', 3, 14, 'yes');
INSERT INTO Books VALUES ('The Norwood Builder', 'Crime Mystery', 'Conan Doyle', 4, 15, 'no');
INSERT INTO Books VALUES ('The Dancing Men', 'Crime Mystery', 'Conan Doyle', 4, 15.2, 'no');
INSERT INTO Books VALUES ('The Solitary Cyclist', 'Crime Mystery', 'Conan Doyle', 4, 13, 'no');
INSERT INTO Books VALUES ('The Priory School', 'Crime Mystery', 'Conan Doyle', 4, 13, 'no');
INSERT INTO Books VALUES ('The Three Students', 'Crime Mystery', 'Conan Doyle', 4, 15, 'no');

SELECT * FROM Books;

--DDL Users table creation
CREATE TABLE Users (
	UserId int PRIMARY KEY NOT NULL IDENTITY(1,1),
	FirstName varchar(100) NOT NULL,
	LastName varchar(100) NOT NULL,
);         

SELECT * FROM Users;

--DML Inserting books into Books table
INSERT INTO Users VALUES ('Arshad', 'Shareef');
INSERT INTO Users VALUES ('Gohar', 'Ali');
INSERT INTO Users VALUES ('Saleem', 'Safi');
INSERT INTO Users VALUES ('Arqam', 'Nazeer');
INSERT INTO Users VALUES ('Arbaz', 'Khan');
INSERT INTO Users VALUES ('Naila', 'Imran');
INSERT INTO Users VALUES ('Sumaira', 'Sajid');
INSERT INTO Users VALUES ('Danish', 'Ali');
INSERT INTO Users VALUES ('Shizza', 'Zulfiqar');
INSERT INTO Users VALUES ('Majid', 'Ahmed');

SELECT * FROM Users;

--DDL IssuedBooks table creation
CREATE TABLE IssuedBooks (
	IssuedBookId int PRIMARY KEY NOT NULL IDENTITY(1,1),
	BookId int NOT NULL UNIQUE FOREIGN KEY  REFERENCES Books(BookId) ON DELETE CASCADE,
	UserId int NOT NULL FOREIGN KEY  REFERENCES Users(UserId)
);

SELECT * FROM IssuedBooks;

--DML Inserting issued books details into IssuedBooks table
INSERT INTO IssuedBooks VALUES (1, 1);
INSERT INTO IssuedBooks VALUES (3, 2);
INSERT INTO IssuedBooks VALUES (4, 2);
INSERT INTO IssuedBooks VALUES (5, 3);
INSERT INTO IssuedBooks VALUES (6, 3);
INSERT INTO IssuedBooks VALUES (7, 4);
INSERT INTO IssuedBooks VALUES (8, 4);
INSERT INTO IssuedBooks VALUES (9, 5);
INSERT INTO IssuedBooks VALUES (10, 5);
INSERT INTO IssuedBooks VALUES (11, 6);
INSERT INTO IssuedBooks VALUES (12, 7);
INSERT INTO IssuedBooks VALUES (13, 8);
INSERT INTO IssuedBooks VALUES (14, 10);

SELECT * FROM IssuedBooks;



--Stored procedures------------------------------------------------
GO;

CREATE PROCEDURE spGetBooks
AS
SELECT * FROM Books;

GO;

CREATE PROCEDURE spGetUsers
AS
SELECT * FROM Users;

GO;

--CREATE PROCEDURE spGetUserAndIssuedBooks
--AS
--BEGIN
--SELECT Users.UserId, Users.FirstName, Users.LastName, Books.BookName
--FROM Users
--INNER JOIN IssuedBooks ON IssuedBooks.UserId = Users.UserId
--INNER JOIN Books ON IssuedBooks.BookId = Books.BookId
--END

GO;

CREATE PROCEDURE spInsertBook
@BookName varchar(100),
@Category varchar(100),
@Author varchar(100),
@ShelfNumber int,
@Price float
--@Issued varchar(100)
AS
BEGIN
INSERT INTO Books VALUES (@BookName, @Category, @Author, @ShelfNumber, @Price, default);
END

GO;

CREATE PROCEDURE spGetBookByName
@InputBookName varchar(100)
AS
SELECT * 
FROM Books
WHERE BookName = @InputBookName;

GO;

CREATE PROCEDURE spInsertUser
@FirstName varchar(100),
@LastName varchar(100)
AS
BEGIN
INSERT INTO Users VALUES (@FirstName, @LastName);
END

GO;

--CREATE PROCEDURE spGetUserAndIssuedBooks_ById
--@UserId int
--AS
--BEGIN
--SELECT Users.UserId, Users.FirstName, Users.LastName, Books.BookName
--FROM Users
--INNER JOIN IssuedBooks ON IssuedBooks.UserId = Users.UserId
--INNER JOIN Books ON IssuedBooks.BookId = Books.BookId
--WHERE IssuedBooks.UserId = @UserId
--END

CREATE PROCEDURE spGetUserAndIssuedBooks_ById
@UserId int
AS
BEGIN
SELECT Users.UserId, Users.FirstName, Users.LastName, Books.BookName
FROM Users
left JOIN IssuedBooks ON IssuedBooks.UserId = Users.UserId
left JOIN Books ON IssuedBooks.BookId = Books.BookId
WHERE Users.UserId = @UserId
END

GO;
--CREATE PROCEDURE spGetUserAndIssuedBooks_ById
--@UserId int,
--@Check int OUTPUT
--AS
--BEGIN
--IF (select count(UserId) from IssuedBooks where UserId = @UserId) = 0
--	BEGIN
--	SET @Check = 1
--	(SELECT Users.UserId, Users.FirstName, Users.LastName
--	FROM Users
--	WHERE UserId = @UserId)
--	END
--ELSE
--	BEGIN
--	SET @Check = 2
--	(SELECT Users.UserId, Users.FirstName, Users.LastName, Books.BookName
--	FROM Users
--	INNER JOIN IssuedBooks ON IssuedBooks.UserId = Users.UserId
--	INNER JOIN Books ON IssuedBooks.BookId = Books.BookId
--	WHERE IssuedBooks.UserId = @UserId)
--	END
--END

--exec spGetUserAndIssuedBooks_ById 9

GO;

--select count(UserId) from IssuedBooks where UserId = 9;
if (select count(UserId) from IssuedBooks where UserId = 9) > 0
	select * from Users;
else
	select * from Books;


GO;

CREATE PROCEDURE spUpdateBookById
@BookName varchar(100),
@Category varchar(100),
@Author varchar(100),
@ShelfNumber int,
@Price float,
@inputBookId int
--@Issued varchar(100)
AS
BEGIN
UPDATE Books
SET BookName=@BookName, Category=@Category, Author=@Author, ShelfNumber=@ShelfNumber, Price=@Price
WHERE BookId = @inputBookId;
END

GO;

CREATE PROCEDURE spUpdateUserById
@FirstName varchar(100),
@LastName varchar(100),
@inputUserId int
AS
BEGIN
UPDATE Users
SET FirstName=@FirstName, LastName=@LastName
WHERE UserId = @inputUserId;
END

GO;

CREATE PROCEDURE spIssueBook
@inputUserId int,
@inputBookId int
AS
BEGIN
--Adds book to the issued books table
INSERT INTO IssuedBooks VALUES (@inputBookId, @inputUserId);
--Updates the issued status of book in Books table
UPDATE Books
SET Issued = 'yes'
WHERE BookId = @inputBookId;
END

GO;

--EXEC spIssueBook 4, 7

CREATE PROCEDURE spRemoveBook
@InputBookName varchar(100)
AS
BEGIN
DELETE FROM Books --record will also get deleted from issued books table
WHERE BookName=@InputBookName;
END

GO;

CREATE PROCEDURE spRemoveUser
@InputUserId int
AS
BEGIN
DELETE FROM Users --The user will not be deleted if it has issued a book
WHERE UserId = @InputUserId;
END

GO;

CREATE PROCEDURE spReturnBook
@InputBookName varchar(100)
AS
BEGIN
--removes book from issued list
DELETE FROM IssuedBooks 
WHERE BookId = (SELECT BookId FROM Books WHERE BookName = @InputBookName);
--changes the issue status of book in Books table
UPDATE Books
SET Issued = 'no'
WHERE BookName = @InputBookName;
END

GO;

--EXEC spReturnBook 'A Dream of Spring'
--select * from Penalty;