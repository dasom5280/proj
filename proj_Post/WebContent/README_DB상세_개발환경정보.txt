���� ȯ��� �����ͺ��̽�(my-sql) ��

1. ���� ȯ��

- �ϵ�������� : 
	CPU : Intel(R) Core(TM) i5-8250U @ 1.60GHz, 1.80GHz 
	RAM : 8.0 GB
	SSD : SK Hynix HFS128G39TND-N210A
	HDD : TOSHIBA MQ01ABF050
	VGA : Intel(R) UHD Graphics 620, NVIDIA GeForce MX150

- ����� �ü���� ��������(=����)
	Windows 10 Home x64

- ���߿� �ʿ��� ���α׷������ ��������
	Java (jdk version : 10.0.1)
	JSP (model-1 architecture)
	HTML, CSS, Javascript, jQuery

- ���α׷����ۿ� ������ ��������
	DE : Eclipse Java EE IDE 4.8 (Photon)
	Server : Tomcat (version : 8.5)
	Database : My-SQL (version : 8.0.12)
	Library : cos.jar, connector-J (version : 8.0.12), Bootstrap (version: 4.3.1)

2. �����ͺ��̽� ��(������)

create database mydb;

#ȸ�� ���� ����
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

#ȸ�� �α��� ��� ����
create table accessrecord (
id varchar(20),
loginTime datetime,
ip varchar(15),
constraint foreign key (id) references tblMember (id)
);

#��ǰ ���� ����
create table tblproduct (
productNum int(20) PRIMARY KEY auto_increment,
productName varchar(50),
productType varchar(10),
explanation varchar(50),
price varchar(20),
inventory varchar(10),
sale int(1), // ����X - 0, ����O-1
filename varchar(50), // ��ǰ �̹��� ���� �̸�
filesize int(11), // ��ǰ �̹��� ���� ũ��
salePercent int(3) // ���� ����� ������
);

#��ٱ���, ���� ���� ����
create table tblbasket (
basketNum int(20) PRIMARY KEY auto_increment,
id varchar(20),
productType varchar(10),
productNum varchar(20),
productName varchar(50),
price varchar(20),
quantity int(3),
buy int(1), // 0 - ��ٱ���, 1 - ���� �Ϸ�, 2 - ��� ó�� �Ϸ�
buydate datetime, // ���� �ð�
paddress varchar(60), // ���Ž� ��� �ּ�
pzipcode char(6), // ���Ž� ��� �����ȣ
payment int(1), // ���Ҽ���, 1-�ſ�ī�� 2-������ü 3-�޴�������
constraint foreign key (id) references tblMember (id)
);

#�������� �Խ��� ���� ����
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

#�����Խ��� ��������
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

#Q&A�Խ��� ��������
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
answer char(1), // �亯 ��� - 0, �亯 �Ϸ� - 1
productName varchar(50)
);
