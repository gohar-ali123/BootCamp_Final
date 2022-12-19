------DDL Database creation--------
CREATE DATABASE DB_DiscussionForumAPI;

--DDL Users table creation
CREATE TABLE Users (
	Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
	FullName varchar(50) NOT NULL,
	UserName varchar(20) NOT NULL UNIQUE,
	Email varchar(50) NOT NULL UNIQUE,
	Password varchar(20) NOT NULL,
	Role varchar(10) NOT NULL,
);

SELECT * FROM Users;

--DML Inserting users into users table
--INSERT INTO Users VALUES ('G 123', 'G123', 'G123@gmail.com', '123','Superuser');
INSERT INTO Users VALUES ('I 123', 'I123', 'I123@gmail.com', '123','Instructor');
INSERT INTO Users VALUES ('C 234', 'C234', 'C234@gmail.com', '234','Candidate');
INSERT INTO Users VALUES ('IB 123', 'IB123', 'IB123@gmail.com', 'B123','Instructor');
INSERT INTO Users VALUES ('CB 234', 'CB234', 'CB234@gmail.com', 'B234','Candidate');

SELECT * FROM Users;

------DDL Posts table creation------
CREATE TABLE Posts (
	Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
	Topic varchar(50) NOT NULL,
	Content varchar(max) NOT NULL,
	PostDate SMALLDATETIME NOT NULL DEFAULT GETDATE(),
	UserId int NOT NULL FOREIGN KEY  REFERENCES Users(Id) ON DELETE CASCADE,
	UpVoteCount int NOT NULL DEFAULT 0,
	DownVoteCount int NOT NULL DEFAULT 0
);

SELECT * FROM Posts;

------DDL Votes table creation------
CREATE TABLE Votes (
	Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
	Type varchar(10) NOT NULL,
	UserId int NOT NULL FOREIGN KEY  REFERENCES Users(Id),
	PostId int NOT NULL FOREIGN KEY  REFERENCES Posts(Id) ON DELETE CASCADE
);

SELECT * FROM Votes;

------DDL Comments table creation-----
CREATE TABLE Comments (
	Id int PRIMARY KEY NOT NULL IDENTITY(1,1),
	Content varchar(max) NOT NULL,
	UserId int NOT NULL FOREIGN KEY  REFERENCES Users(Id),
	PostId int NOT NULL FOREIGN KEY  REFERENCES Posts(Id) ON DELETE CASCADE
);

SELECT * FROM Comments;

--------------------------------------STORED PROCEDURES---------------------------------------------

GO;

CREATE PROCEDURE spGetPosts
AS
SELECT * FROM Posts;

GO;

---Task2---
CREATE PROCEDURE spCreatePost
@Topic varchar(50),
@Content varchar(max),
--@PostDate SMALLDATETIME,
@UserId int
AS
BEGIN
INSERT INTO Posts VALUES (@Topic, @Content, default, @UserId, default, default);
END

exec spCreatePost 'T1', 'Lorem ipsum dolor sit amet, consectetur', '2008-11-11 13:23:44', 1

GO;

---Task3---
CREATE PROCEDURE spCreateComment
@Content varchar(max),
@UserId int,
@PostId int
AS
BEGIN
INSERT INTO Comments VALUES (@Content,@UserId, @PostId);
END

GO;

---Task4---
CREATE PROCEDURE spDeletePost
@UserId int,
@PostId int
AS
BEGIN
DELETE FROM Posts --votes and comments of the post will also get deleted
WHERE Id = @PostId AND UserId = @UserId;
END

GO;

CREATE PROCEDURE spUpdatePost_ById
@UserId int,
@PostId int,
@Topic varchar(50),
@Content varchar(max)
AS
BEGIN
UPDATE Posts
SET Topic = @Topic, Content = @Content
WHERE Id = @PostId AND UserId = @UserId;
END

GO;

---Task5---
CREATE PROCEDURE spDeleteComment
@UserId int,
@CommentId int
AS
BEGIN
DELETE FROM Comments
WHERE Id = @CommentId AND UserId = @UserId;
END

GO;

CREATE PROCEDURE spUpdateComment_ById
@UserId int,
@CommentId int,
@Content varchar(max)
AS
BEGIN
UPDATE Comments
SET Content = @Content
WHERE Id = @CommentId AND UserId = @UserId;
END

GO;

---Task6---

--////////UpVote logic
CREATE PROCEDURE spCreateUpVote
@UserId int,
@PostId int
AS
BEGIN
INSERT INTO Votes VALUES ('UpVote', @UserId, @PostId); --Adds new vote of type UpVote
UPDATE Posts  --Updates UpVoteCount in Posts table
SET UpVoteCount+=1
WHERE Id = @PostId;
END

--exec spCreateUpVote 1, 1
GO;

CREATE PROCEDURE spUpVote
@UserId int,
@PostId int
AS
BEGIN
if EXISTS(SELECT Id FROM Votes WHERE PostId = @PostId AND UserId = @UserId)
BEGIN
	if EXISTS(SELECT Id FROM Votes WHERE PostId = @PostId AND UserId = @UserId AND Type = 'UpVote')
		BEGIN
		UPDATE Posts	--Decreases UpVoteCount in Posts table
		SET UpVoteCount-=1
		WHERE Id = @PostId AND UserId = @UserId; 
		DELETE FROM Votes	--Removes vote from Votes table
		WHERE PostId = @PostId AND UserId = @UserId;
		END
	else if EXISTS(SELECT Id FROM Votes WHERE PostId = @PostId AND UserId = @UserId AND Type = 'DownVote')
		BEGIN
		UPDATE Posts	--Increases UpVoteCount in Posts table
		SET UpVoteCount+=1
		WHERE Id = @PostId AND UserId = @UserId; 
		UPDATE Posts	--Decreases DownVoteCount in Posts table
		SET DownVoteCount-=1
		WHERE Id = @PostId AND UserId = @UserId;
		UPDATE Votes
		SET Type = 'UpVote'
		WHERE PostId = @PostId AND UserId = @UserId;
		END
END
else
	exec spCreateUpVote @UserId, @PostId
END

exec spUpVote 1, 1
GO;

--////////DownVote logic
CREATE PROCEDURE spCreateDownVote
@UserId int,
@PostId int
AS
BEGIN
INSERT INTO Votes VALUES ('DownVote', @UserId, @PostId); --Adds new vote of type DownVote
UPDATE Posts  --Updates DownVoteCount in Posts table
SET DownVoteCount+=1
WHERE Id = @PostId;
END

--exec spCreateUpVote 1, 1
GO;

CREATE PROCEDURE spDownVote
@UserId int,
@PostId int
AS
BEGIN
if EXISTS(SELECT Id FROM Votes WHERE PostId = @PostId AND UserId = @UserId)
BEGIN
	if EXISTS(SELECT Id FROM Votes WHERE PostId = @PostId AND UserId = @UserId AND Type = 'DownVote')
		BEGIN
		UPDATE Posts	--Decreases DownVoteCount in Posts table
		SET DownVoteCount-=1
		WHERE Id = @PostId AND UserId = @UserId; 
		DELETE FROM Votes	--Removes vote from Votes table
		WHERE PostId = @PostId AND UserId = @UserId;
		END
	else if EXISTS(SELECT Id FROM Votes WHERE PostId = @PostId AND UserId = @UserId AND Type = 'UpVote')
		BEGIN
		UPDATE Posts	--Increases DownVoteCount in Posts table
		SET DownVoteCount+=1
		WHERE Id = @PostId AND UserId = @UserId; 
		UPDATE Posts	--Decreases UpVoteCount in Posts table
		SET UpVoteCount-=1
		WHERE Id = @PostId AND UserId = @UserId;
		UPDATE Votes
		SET Type = 'DownVote'
		WHERE PostId = @PostId AND UserId = @UserId;
		END
END
else
	exec spCreateDownVote @UserId, @PostId
END

--exec spDownVote 1, 1
GO;