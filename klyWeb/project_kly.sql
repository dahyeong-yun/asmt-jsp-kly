-- CREATE TABLE
CREATE TABLE MEMBER(
	MEMBER_ID NVARCHAR2(50) NOT NULL,
	MEMBER_PW NVARCHAR2(50) NOT NULL,
	MEMBER_TEMPPASS NVARCHAR2(50),
	MEMBER_SETTEMP NUMBER,
	MEMBER_EMAIL NVARCHAR2(50) NOT NULL,
	MEMBER_CHECKED NUMBER DEFAULT 0,
	MEMBER_DATE DATE NOT NULL,
	MEMBER_SUSPENDED DATE,
	PRIMARY KEY(MEMBER_ID)
);
/*
ALTER TABLE MEMBER
MODIFY(MEMBER_TEMPPASS NVARCHAR2(50));

ALTER TABLE MEMBER
ADD(MEMBER_SETTEMP NUMBER DEFAULT 0);
*/

CREATE TABLE BOARD(
	MEMBER_ID NVARCHAR2(50) NOT NULL,
	BOARD_NUM NUMBER NOT NULL,
	BOARD_SUBJECT NVARCHAR2(100) NOT NULL,
	BOARD_DATE DATE NOT NULL,
	BOARD_FILE NVARCHAR2(200),
	BOARD_URL NVARCHAR2(200),
	BOARD_READCOUNT NUMBER DEFAULT 0,
	BOARD_LIKECOUNT NUMBER DEFAULT 0,
	BOARD_REPORTCOUNT NUMBER DEFAULT 0, -- 신고테이블에 신고 카운트 제거 하고 보드테이블에 추가
	BOARD_TAG NVARCHAR2(50),
	BOARD_CATEGORY NVARCHAR2(50) NOT NULL,
	BOARD_BLIND NUMBER DEFAULT 0, -- what for this
	BOARD_YOUTUBE_ID NVARCHAR2(20),
	PRIMARY KEY(BOARD_NUM),
	CONSTRAINT FK_BOARD FOREIGN KEY(MEMBER_ID)
	REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE
);

CREATE TABLE BOARD_COMMENT (
	BOARD_NUM NUMBER NOT NULL,
	MEMBER_ID NVARCHAR2(50) NOT NULL,
	COMMENT_NUM NUMBER NOT NULL,
	COMMENT_CON NVARCHAR2(1024) NOT NULL,
	COMMENT_DATE DATE NOT NULL,
	COMMENT_BLIND NUMBER DEFAULT 0,
	PRIMARY KEY(COMMENT_NUM),
	CONSTRAINT FK_COMMENT_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE,
	CONSTRAINT FK_COMMENT_ARTICLE FOREIGN KEY(BOARD_NUM)
	REFERENCES BOARD(BOARD_NUM) ON DELETE CASCADE
);

CREATE TABLE LIKED(
	LIKE_NUM NUMBER NOT NULL,
	MEMBER_ID NVARCHAR2(50) NOT NULL,
	BOARD_NUM NUMBER NOT NULL,
	-- 특정 게시물에 대한 전체 좋아요 갯수
	PRIMARY KEY(LIKE_NUM),
	CONSTRAINT FK_LIKE_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE,
	CONSTRAINT FK_LIKE_ARTICLE FOREIGN KEY(BOARD_NUM)
	REFERENCES BOARD(BOARD_NUM) ON DELETE CASCADE
);

CREATE TABLE REPORT(
	MEMBER_ID NVARCHAR2(50) NOT NULL,
	BOARD_NUM NUMBER NOT NULL,
	REPORT_NUM NUMBER NOT NULL,
	REPORT_COUNT NUMBER DEFAULT 0,
	REPORT_DATE DATE,
	PRIMARY KEY(REPORT_NUM),
	CONSTRAINT FK_REPORT_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE,
	CONSTRAINT FK_REPORT_ARTICLE FOREIGN KEY(BOARD_NUM)
	REFERENCES BOARD(BOARD_NUM) ON DELETE CASCADE
);

-- Dummy Data MEMBER
INSERT INTO MEMBER VALUES('123','123',null,0,'gryb809@naver.com',0,Sysdate,Sysdate);
INSERT INTO MEMBER VALUES('qwe','123',null,0,'gryb809@naver.com',1,sysdate,Sysdate);
INSERT INTO MEMBER VALUES('admin','123',null,0,'gryb809@naver.com',1,sysdate,Sysdate);
INSERT INTO MEMBER VALUES('tempId','123',null,0,'gryb809@naver.com',1,sysdate,Sysdate);
INSERT INTO MEMBER VALUES('A','1234',null,0,'dwqwe2@gmail.com',0,sysdate,Sysdate);
INSERT INTO MEMBER VALUES('B','1234',null,0,'dwqwe2@gmail.com',0,sysdate,Sysdate);
INSERT INTO MEMBER VALUES('C','1234',null,0,'Jony123@gmail.com',0,sysdate,Sysdate);
INSERT INTO MEMBER VALUES('D','1234',null,0,'dfdsfw@gmail.com',0,sysdate,Sysdate);
INSERT INTO MEMBER VALUES('E','1234',null,0,'whdwrkdgu@daum.net',0,sysdate,Sysdate);

-- Dummy Data BOARD
INSERT INTO BOARD VALUES('A',1,'aA',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/zjwqIyoWV8c" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',10,5,0,'롤','게임',0,'zjwqIyoWV8c');
INSERT INTO BOARD VALUES('B',2,'aB',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/sB-yuZ2Qncg" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',5,10,0,'배그','게임',0,'sB-yuZ2Qncg');
INSERT INTO BOARD VALUES('C',3,'aC',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/1yDYGOFc5qY" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'일상','유머',0,'1yDYGOFc5qY');
INSERT INTO BOARD VALUES('D',4,'aD',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/9Xlc_UyjQQY" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'축구','스포츠',0,'9Xlc_UyjQQY');
INSERT INTO BOARD VALUES('E',5,'aE',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/f3P_lHInI14" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'배그','동물',0,'f3P_lHInI14');
INSERT INTO BOARD VALUES('E',6,'a1',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/f3P_lHInI14" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'개','동물',0,'f3P_lHInI14');
INSERT INTO BOARD VALUES('E',7,'a2',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/f3P_lHInI14" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'개','동물',0,'f3P_lHInI14');
INSERT INTO BOARD VALUES('E',8,'a3',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/f3P_lHInI14" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'개','동물',0,'f3P_lHInI14');
INSERT INTO BOARD VALUES('E',9,'a4',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/f3P_lHInI14" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'개','동물',0,'f3P_lHInI14');
INSERT INTO BOARD VALUES('E',10,'a5',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/f3P_lHInI14" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'개','동물',0,'f3P_lHInI14');
INSERT INTO BOARD VALUES('E',11,'a6',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/f3P_lHInI14" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'개','동물',0,'f3P_lHInI14');
INSERT INTO BOARD VALUES('E',12,'a7',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/f3P_lHInI14" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'개','동물',0,'f3P_lHInI14');
INSERT INTO BOARD VALUES('E',13,'a8',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/f3P_lHInI14" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'개','동물',0,'f3P_lHInI14');
INSERT INTO BOARD VALUES('E',14,'a9',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/f3P_lHInI14" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'개','동물',0,'f3P_lHInI14');
INSERT INTO BOARD VALUES('E',15,'a10',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/f3P_lHInI14" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'개','동물',0,'f3P_lHInI14');
INSERT INTO BOARD VALUES('E',16,'a11',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/f3P_lHInI14" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'개','동물',0,'f3P_lHInI14');
INSERT INTO BOARD VALUES('E',17,'a12',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/f3P_lHInI14" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'개','동물',0,'f3P_lHInI14');
INSERT INTO BOARD VALUES('E',18,'a13',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/f3P_lHInI14" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'개','동물',0,'f3P_lHInI14');
INSERT INTO BOARD VALUES('E',19,'a14',Sysdate,null,'<iframe width="420" height="315" src="https://www.youtube.com/embed/f3P_lHInI14" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>',0,0,0,'개','동물',0,'f3P_lHInI14');

-- Dummy Data COMMENT
INSERT INTO BOARD_COMMENT VALUES(1,'B',1,'추천 누르고 갑니다',SYSDATE,0);
INSERT INTO BOARD_COMMENT VALUES(1,'C',2,'재밌네요',SYSDATE,0);
INSERT INTO BOARD_COMMENT VALUES(1,'D',3,'ㅋㅋㅋㅋㅋㅋㅋㅋ',SYSDATE,0);
INSERT INTO BOARD_COMMENT VALUES(2,'B',4,'이걸 이렇게???',SYSDATE,0);
INSERT INTO BOARD_COMMENT VALUES(2,'B',5,'뭐지..',SYSDATE,0);
INSERT INTO BOARD_COMMENT VALUES(1,'tempId',6, 'asd',SYSDATE,6);
INSERT INTO BOARD_COMMENT VALUES(1,'tempId',7,'Asdasss',SYSDATE,5);
INSERT INTO BOARD_COMMENT VALUES(1,'tempId',8,'ASdasdsadkj',SYSDATE,4);
INSERT INTO BOARD_COMMENT VALUES(1,'qwe',9,'ㅋㅋㅋㅋㅋㅋadkj',SYSDATE,0);
INSERT INTO BOARD_COMMENT VALUES(1,'qwe',10,'get the fuck out a here',SYSDATE,4);
INSERT INTO BOARD_COMMENT VALUES(1,'qwe',11,'반갑습니다',SYSDATE,0);

-- Dummy Data LIKED
INSERT INTO LIKED VALUES(1,'tempId',1);
INSERT INTO LIKED VALUES(2,'tempId',2);
INSERT INTO LIKED VALUES(3,'qwe',1);
INSERT INTO LIKED VALUES(4,'qwe',2);

-- Dummy Data REPORT
INSERT INTO REPORT VALUES('tempId',1,1,1,SYSDATE);
INSERT INTO REPORT VALUES('qwe',1,2,8,SYSDATE);
INSERT INTO REPORT VALUES('123',1,3,5,SYSDATE);

-- QUICK

UPDATE MEMBER SET MEMBER_CHECKED = 1 WHERE MEMBER_ID='123';
SELECT * FROM MEMBER;
SELECT * FROM BOARD;
SELECT * FROM BOARD_COMMENT;
SELECT * FROM LIKED;
SELECT * FROM REPORT;

DESC BOARD_COMMENT;
DESC BOARD;
DESC LIKED;
DESC REPORT;

DROP TABLE MEMBER;
DROP TABLE BOARD;
DROP TABLE BOARD_COMMENT;
DROP TABLE LIKED;
DROP TABLE REPORT;

DELETE FROM MEMBER WHERE MEMBER_ID = '123';

COMMIT;
