CREATE TABLE PLAYER(
    player_id varchar(6) PRIMARY KEY not null,
    pname VARCHAR(30) ,
    teamid varchar(6),
    height float,
    birthday DATE NOT NULL,
    played_matches int DEFAULT 0,
    foreign key (teamid) references TEAM(teamid),
    check(ascii(substr(pname,1,1)) between 65 and 90)
);


drop table player;
CREATE TABLE TEAM(
    teamid varchar(6) PRIMARY KEY,
    Coach varchar(20) UNIQUE,
    Won_games int DEFAULT 0,
    check(teamid like 'T%')
);


CREATE TABLE MATCH(
    matchid int primary key not null,
    mdate DATE,
    Teamid1 varchar(6),
    Teamid2 varchar(6),
    winnerteamid varchar(6),
    refree varchar(30),
    FOREIGN KEY (Teamid1) REFERENCES TEAM(teamid),
    FOREIGN KEY (Teamid2) REFERENCES TEAM(teamid),
    FOREIGN KEY (winnerteamid) REFERENCES TEAM(teamid),
    check(Teamid1!=Teamid2),
    check(winnerteamid=Teamid1 or winnerteamid=Teamid2)
 );
 


 
 CREATE SEQUENCE mseq minvalue 0 start with 0 increment by 1;
 
CREATE TABLE PLAYED(
    matchid int,
    player_id varchar(5),
    Role char(6),
    ScoredPoints int,
    CHECK(Role in ('Head', 'player')),
    CHECK(ScoredPoints BETWEEN 0 and 25),
    PRIMARY KEY (matchid, player_id),
    FOREIGN KEY (player_id) REFERENCES PLAYER(player_id),
    FOREIGN KEY (matchid) REFERENCES MATCH(matchid)
);



insert into team values('T1','Mahi',2);
insert into team values('T2','Deadpool',3);
insert into team values('T3','Sant',4);
insert into team values('T4','Jass',5);
insert into team values('T5','Rk',6);


INSERT INTO PLAYER VALUES('P1','Bala','T1',165,'02-MAY-2002',1);
INSERT INTO PLAYER  VALUES('P2','Levii','T2',170,'09-JUN-2003',1);
INSERT INTO PLAYER VALUES('P3','Perch','T3',158,'18-APR-2002',1);
INSERT INTO PLAYER VALUES('P4','Kr','T4',174,'25-DEC-2002',1);
INSERT INTO PLAYER VALUES('P5','Robert','T5',160,'11-JUL-2002',4);




INSERT INTO MATCH VALUES(mseq.nextval,'10-MAY-2021','T1','T2','T1','REF1');
INSERT INTO MATCH VALUES(mseq.nextval,'1-MAY-2021','T1','T3','T3','REF3');
INSERT INTO MATCH VALUES(mseq.nextval,'12-MAY-2021','T2','T3','T2','REF2');
INSERT INTO MATCH VALUES(mseq.nextval,'13-MAY-2021','T3','T4','T3','REF4');

INSERT INTO MATCH VALUES(mseq.nextval,'14-MAY-2021','T1','T4','T4','REF2');

INSERT INTO PLAYED VALUES(0,'P1','Head',8);
INSERT INTO PLAYED VALUES(1,'P2','player',11);
INSERT INTO PLAYED VALUES(2,'P3','Head',15);
INSERT INTO PLAYED VALUES(3,'P4','Head',9);
INSERT INTO PLAYED VALUES(2,'P5','player',13);


drop table played;

set SERVEROUTPUT on

--3 1)
DECLARE
maxAvg int;
PlId int;
PlayerName varchar(20);
BEGIN
select max(avg(ScoredPts)) into maxAvg from Played group by PlayerId;
select PlayerId, Name into PlId, PlayerName from Played join Player using(PlayerId) group by PlayerId, Name having avg(ScoredPts) = maxAvg;
dbms_output.put_line('Player Id:' || PlId || ' ' ||'Player Name:' || PlayerName);
dbms_output.put_line('Matches played:');
for i in (select MatchId from Played where PlayerId = PlId)
loop
dbms_output.put_line(i.MatchId);
end loop;
END;
/

-- 3 2)
DECLARE
    rows1 number(2);
BEGIN
    UPDATE played
    SET ScoredPoints=ScoredPoints+0.05*ScoredPoints where Role='Head' and ScoredPoints<23.75;
    IF sql%notfound THEN 
      dbms_output.put_line('No rows updated'); 
    ELSIF sql%found THEN 
      rows1 := sql%rowcount;
      dbms_output.put_line( rows1 || ' rows are updated '); 
    END IF;
END;
/






-- 4 1)

create or replace trigger trig1 after insert on match
for each row
begin
update team set Won_games=Won_games+1 where teamid=(:new.winnerteamid);
end;
/



--4 2)
create or replace trigger trig2 after insert on played
for each row
begin
update player set played_matches=played_matches+1 where player_id=(:new.player_id);
end;
/



--4 3)
create or replace trigger trig3
before insert 
on played
for each row
declare 
a int;
begin
select played_matches into a from player where(:new.player_id=player_id);
if(a+1>2) then
raise_application_error(-20001,'Cannot be inserted');
end if;
end;
/
