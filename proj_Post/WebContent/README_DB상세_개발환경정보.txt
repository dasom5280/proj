개발 환경과 데이터베이스(my-sql) 상세

1. 개발 환경

- 하드웨어정보 : 
	CPU : Intel(R) Core(TM) i5-8250U @ 1.60GHz, 1.80GHz 
	RAM : 8.0 GB
	SSD : SK Hynix HFS128G39TND-N210A
	HDD : TOSHIBA MQ01ABF050
	VGA : Intel(R) UHD Graphics 620, NVIDIA GeForce MX150

- 사용할 운영체제와 형상정보(=버전)
	Windows 10 Home x64

- 개발에 필요한 프로그램언어명과 형상정보
	Java (jdk version : 10.0.1)
	JSP (model-1 architecture)
	HTML, CSS, Javascript, jQuery

- 프로그램제작용 도구와 형상정보
	DE : Eclipse Java EE IDE 4.8 (Photon)
	Server : Tomcat (version : 8.5)
	Database : My-SQL (version : 8.0.12)
	Library : cos.jar, connector-J (version : 8.0.12), Bootstrap (version: 4.3.1)

2. 데이터베이스 상세(쿼리문)

create database mydb;

#회원 정보 저장
create table tblmember (
id varchar(20) PRIMARY KEY,
pass varchar(20),
namem varchar(20),
gender char(2),
email varchar(30),
birthday char(6),
zipcode char(6),
address varchar(60),
phoneNum varchar(15),
level int(2),
points int(10)
);

#회원 로그인 기록 저장
create table accessrecord (
id varchar(20),
loginTime datetime,
ip varchar(15),
constraint foreign key (id) references tblMember (id)
);

#상품 정보 저장
create table tblproduct (
productNum int(20) PRIMARY KEY auto_increment,
productName varchar(50),
productType varchar(10),
explanation varchar(50),
price varchar(20),
inventory varchar(10),
sale int(1), // 세일X - 0, 세일O-1
filename varchar(50), // 상품 이미지 파일 이름
filesize int(11), // 상품 이미지 파일 크기
salePercent int(3) // 세일 진행시 할인율
);

#장바구니, 구매 정보 저장
create table tblbasket (
basketNum int(20) PRIMARY KEY auto_increment,
id varchar(20),
productType varchar(10),
productNum varchar(20),
productName varchar(50),
price varchar(20),
quantity int(3),
buy int(1), // 0 - 장바구니, 1 - 구매 완료, 2 - 배송 처리 완료
buydate datetime, // 구매 시각
paddress varchar(60), // 구매시 배송 주소
pzipcode char(6), // 구매시 배송 우편번호
payment int(1), // 지불수단, 1-신용카드 2-계좌이체 3-휴대폰결제
constraint foreign key (id) references tblMember (id)
);

#공지사항 게시판 정보 저장
create table tblboard (
num int(11) PRIMARY KEY auto_increment,
name varchar(20),
subject varchar(50),
content text,
pos smallint(7) unsigned,
ref smallint(7),
depth smallint(7) unsigned,
regdate datetime,
pass varchar(15),
ip varchar(15),
count smallint(7)  unsigned
);

#자유게시판 정보저장
create table tblfreeboard (
num int(11) PRIMARY KEY auto_increment,
name varchar(20),
subject varchar(50),
content text,
pos smallint(7) unsigned,
ref smallint(7),
depth smallint(7) unsigned,
regdate datetime,
pass varchar(15),
ip varchar(15),
count smallint(7)  unsigned
);

#Q&A게시판 정보저장
create table tblqna (
num int(11) PRIMARY KEY auto_increment,
id varchar(20),
subject varchar(50),
content text,
pos smallint(7) unsigned,
ref smallint(7),
depth smallint(7) unsigned,
regdate datetime,
pass varchar(15),
ip varchar(15),
answer char(1), // 답변 대기 - 0, 답변 완료 - 1
productName varchar(50)
);
