

create table Person
(
name varchar(25) primary key,
age int,
gender varchar(10)
);


create table Frequents
(
name varchar(25),
pizzeria varchar(50),
primary key(name, pizzeria)
);

drop table eats;

create table Eats
(
name varchar(25),
pizza varchar(50),
primary key(name, pizza)
);



create table Serves
(
pizzeria varchar(50),
pizza varchar(50),
price float,
primary key(pizzeria, pizza)
);

insert into Person values('Amy', 16, 'female');
insert into Person values('Ben', 21, 'male');
insert into Person values('Cal', 33, 'male');
insert into Person values('Dan', 13, 'male');
insert into Person values('Eli', 45, 'male');
insert into Person values('Fay', 21, 'female');
insert into Person values('Gus', 24, 'male');
insert into Person values('Hil', 30, 'female');
insert into Person values('Ian', 18, 'male');


insert into Frequents values('Amy', 'Pizza Hut');
insert into Frequents values('Ben', 'Pizza Hut');
insert into Frequents values('Ben', 'Chicago Pizza');
insert into Frequents values('Cal', 'Straw Hat');
insert into Frequents values('Cal', 'New York Pizza');
insert into Frequents values('Dan', 'Straw Hat');
insert into Frequents values('Dan', 'New York Pizza');
insert into Frequents values('Eli', 'Straw Hat');
insert into Frequents values('Eli', 'Chicago Pizza');
insert into Frequents values('Fay', 'Dominos');
insert into Frequents values('Fay', 'Little Caesars');
insert into Frequents values('Gus', 'Chicago Pizza');
insert into Frequents values('Gus', 'Pizza Hut');
insert into Frequents values('Hil', 'Dominos');
insert into Frequents values('Hil', 'Straw Hat');
insert into Frequents values('Hil', 'Pizza Hut');
insert into Frequents values('Ian', 'New York Pizza');
insert into Frequents values('Ian', 'Straw Hat');
insert into Frequents values('Ian', 'Dominos');


insert into Eats values('Amy', 'pepperoni');
insert into Eats values('Amy', 'mushroom');
insert into Eats values('Ben', 'pepperoni');
insert into Eats values('Ben', 'cheese');
insert into Eats values('Cal', 'supreme');
insert into Eats values('Dan', 'pepperoni');
insert into Eats values('Dan', 'cheese');
insert into Eats values('Dan', 'sausage');
insert into Eats values('Dan', 'supreme');
insert into Eats values('Dan', 'mushroom');
insert into Eats values('Eli', 'supreme');
insert into Eats values('Eli', 'cheese');
insert into Eats values('Fay', 'mushroom');
insert into Eats values('Gus', 'mushroom');
insert into Eats values('Gus', 'supreme');
insert into Eats values('Gus', 'cheese'); 
insert into Eats values('Hil', 'supreme');
insert into Eats values('Hil', 'cheese');
insert into Eats values('Ian', 'supreme');
insert into Eats values('Ian', 'pepperoni');


insert into Serves values('Pizza Hut', 'pepperoni', 12);
insert into Serves values('Pizza Hut', 'sausage', 12);
insert into Serves values('Pizza Hut', 'cheese', 9);
insert into Serves values('Pizza Hut', 'supreme', 12);
insert into Serves values('Little Caesars', 'pepperoni', 9.75);
insert into Serves values('Little Caesars', 'sausage', 9.5);
insert into Serves values('Little Caesars', 'cheese', 7);
insert into Serves values('Little Caesars', 'mushroom', 9.25);
insert into Serves values('Dominos', 'cheese', 9.75);
insert into Serves values('Dominos', 'mushroom', 11);
insert into Serves values('Straw Hat', 'pepperoni', 8);
insert into Serves values('Straw Hat', 'cheese', 9.25);
insert into Serves values('Straw Hat', 'sausage', 9.75);
insert into Serves values('New York Pizza', 'pepperoni', 8);
insert into Serves values('New York Pizza', 'cheese', 7);
insert into Serves values('New York Pizza', 'supreme', 8.5);
insert into Serves values('Chicago Pizza', 'cheese', 7.75);
insert into Serves values('Chicago Pizza', 'supreme', 8.5);


SET SERVEROUTPUT ON


--FIRST

BEGIN  
  dbms_output.put_line('NAME  AGE  GENDER');
  FOR R IN (SELECT * FROM PERSON)

  LOOP 

  dbms_output.put_line(R.NAME || '   ' || R.AGE || '    ' || R.GENDER); 

  END LOOP; 

END; 
/ 
 
 
 
 --SECOND
 DECLARE 

  C INT :=1; 

BEGIN  

  FOR R IN (SELECT PIZZA FROM EATS GROUP BY pizza ORDER BY COUNT(*) DESC) 

  LOOP 

  dbms_output.put_line(R.PIZZA); 

  C:=C+1; 

  EXIT WHEN C>3;   

  END LOOP; 

END; 

/

--THIRD
set serveroutput on 

declare 

/*variable for inserting values into person*/ 

name person.name%type; 

age person.age%type; 

gender person.gender%type; 

  

/*variables for inserting values into serves*/ 

  

pizza serves.pizza%type; 

pizzeria serves.pizzeria%type; 

price serves.pizzeria%type; 

  

begin 

    insert into person values ('&name',&age,'&gender'); 

    insert into serves values('&pizza','&pizzeria',&price); 

end; 
/

--FOURTH
/set serveroutput on  

declare  

n int; 

p serves.pizza%type; 

c_pizzeria serves.pizzeria%type; 

c_pizza serves.pizza%type; 

c_price serves.price%type; 

cursor cou is 

    select pizzeria,pizza,price from serves where pizza=p; 

begin  

    p:='&p'; 

    open cou; 

    loop 

    fetch cou into c_pizzeria,c_pizza,c_price; 

        exit when cou%notfound; 

    end loop; 

    n:=cou%rowcount; 

    dbms_output.put_line(n); 

    if n<3 then  

        for i in (select pizzeria from serves where pizza=p) 

            loop 

                dbms_output.put_line(i.pizzeria); 

            end loop; 

    else   

        for i in (select pizzeria,pizza,price from serves where pizza=p) 

            loop 

                dbms_output.put_line(i.pizzeria ||' '||i.pizza||' '||i.price); 

            end loop; 

    end if;  

    close cou; 

end;
/ 

--FIFTH
declare 

res int := 0; 

begin 

update Serves set price = price + price*0.1 where pizzeria = 'Dominos'; 

if sql%notfound then 

DBMS_OUTPUT.PUT_LINE('No row changed'); 

elsif sql%found then 

res := sql%rowcount; 

DBMS_OUTPUT.PUT_LINE(res || ' rows updated'); 

end if; 

end; 

/ 


--SIXTH
BEGIN 

  FOR R IN ( SELECT DISTINCT NAME, PIZZA FROM EATS NATURAL JOIN (SELECT * FROM PERSON WHERE GENDER='female' AND AGE > 20) ) LOOP 

    dbms_output.put_line(R.NAME || ' eats ' || R.PIZZA ||  ' pizza'); 

  END LOOP; 

END; 

/ 


--seventh
BEGIN 

  FOR R IN (SELECT DISTINCT NAME, AGE FROM PERSON NATURAL JOIN (SELECT NAME FROM EATS NATURAL JOIN SERVES WHERE PIZZERIA = 'Straw Hat') WHERE GENDER='female' 

) LOOP 

    dbms_output.put_line(R.NAME || ' ' || R.AGE); 

  END LOOP; 

END; 

/ 

--EIGHT
BEGIN 

  FOR R IN (SELECT DISTINCT PIZZERIA FROM SERVES NATURAL JOIN (SELECT PIZZA FROM EATS WHERE NAME IN ('Amy', 'Fay')) WHERE PRICE <10) 

  LOOP 

    dbms_output.put_line(R.PIZZERIA); 

  END LOOP; 

END; 

/ 

--NINTH
begin 

for c in (select e.pizza from eats e inner join person p on e.name=p.name inner join serves s on s.pizza=e.pizza where p.age<=24 or s.price<10 group by e.pizza) 

    loop  

        dbms_output.put_line(c.pizza); 

    end loop; 

end;
/ 


--TENTH
declare  

  AGE INT;
BEGIN
  SELECT MAX(AGE) INTO AGE FROM PERSON NATURAL JOIN EATS WHERE PIZZA = 'mushroom';
  dbms_output.put_line(AGE);
END;
/



--11
 

begin 

for i in (select pizzeria from person p,frequents f where pizzeria in (select pizzeria from person p, frequents f where p.name = f.name and p.age>30) minus (select pizzeria from person p, frequents f where p.name = f.name and p.age<30)) 

loop 

    dbms_output.put_line( i.pizzeria); 

end loop; 

end;  



--12
begin 

for i in (select DISTINCT pizzeria from Serves where pizza ='pepperoni' and price <(select price from Serves where pizzeria = 'Pizza Hut' and pizza = 'supreme')) 

loop 

DBMS_OUTPUT.PUT_LINE(i.pizzeria); 

end loop; 

end;



--13
BEGIN 

    dbms_output.put_line('AVG_PRICE  PIZZA'); 

    FOR R IN (SELECT pizza, TRUNC (AVG(price), 2) AS avg_price FROM serves GROUP BY pizza HAVING COUNT(*) >=3)LOOP 

        dbms_output.put_line( R.avg_price|| '      '||R.pizza ); 

    END LOOP; 

END; 


--14
BEGIN  

    for i in (SELECT pizzeria FROM serves GROUP BY pizzeria HAVING AVG(price) = (SELECT MAX(AVG(price)) FROM serves GROUP BY pizzeria))loop 

        dbms_output.put_line(i.pizzeria); 
    end loop; 
END;


--15
begin 

for I in (select P.name, P.age from Person P, Frequents F where P.name = F.name and P.gender='male' and F.pizzeria  = 'Straw Hat') 

loop 

dbms_output.put_line(I.name ||' '|| I.age); 

end loop; 

end; 






--16
SELECT object_name,object_type 
FROM user_procedures 
where object_type = 'PROCEDURE';



--17
begin 
for i in (select  pizzeria from Serves  where  price in (select min(price) from Serves where pizza='pepperoni')) 
loop 
DBMS_OUTPUT.PUT_LINE(i.pizzeria); 
end loop; 
end; 

