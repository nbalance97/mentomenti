

drop database mentomenti;
create database mentomenti;
use mentomenti;

create table user(
	id 			varchar(20) primary key,
	pw 			varchar(20) not null,
	birth 		date not null,
	joindate 	date not null,
	email 		varchar(20) not null,
	name 		varchar(20) not null,
	nickname 	varchar(20) not null,
	is_admin 	boolean not null,
	intro 		text
);

create table mmgroup(
	groupid 		int primary key auto_increment,
	name 			varchar(30) not null,
	mentoid 		varchar(20) not null,
	maxperson 		int not null, 
	category 		varchar(20) not null,
	intro text not null,
	constraint group_fk foreign key(mentoid) references user(id) on delete cascade
);

create table class(
	classid 	int primary key auto_increment,
	groupid 	int,
	starttime 	datetime not null,
	endtime 	datetime not null,
	constraint class_fk 
		foreign key(groupid) references mmgroup(groupid) on delete cascade
);

create table classmate(
	id varchar(20) not null,
	classid int not null,
	constraint classmate_pk 
		primary key(id, classid),
	constraint classmate_fk 
		foreign key(id) references user(id) on delete cascade,
	constraint classmate_fk2 
		foreign key(classid) references class(classid) on delete cascade
);

create table groupmate(
	id 			varchar(20) not null,
	groupid 	int not null,
	constraint groupmate_pk 
		primary key(id, groupid),
	constraint groupmate_fk 
		foreign key(groupid) references mmgroup(groupid) on delete cascade
);

create table post(
	postid int primary key auto_increment,
	groupid int,
	userid varchar(20) not null,
	title varchar(30) not null,
	content text not null,
	postdate date not null,
	viewcount int not null,
	is_notice boolean not null,
	constraint post_fk foreign key(userid) references user(id) on delete cascade,
	constraint post_fk2 foreign key(groupid) references mmgroup(groupid) on delete cascade
);

create table comment(
	commentid int primary key auto_increment, 
	postid int not null,
	writerid varchar(20) not null,
	content text not null,
	commentdate date not null,
	constraint t1 foreign key(postid) references post(postid) on delete cascade,
	constraint t2 foreign key(writerid) references user(id) on delete cascade
);

create table notification(
    notificationid int primary key auto_increment,
    receiverid varchar(20) not null,
    sendtime datetime not null,
    content text not null,
    isread boolean not null,
    constraint notification_fk
	foreign key(receiverid) references user(id) on delete cascade
);