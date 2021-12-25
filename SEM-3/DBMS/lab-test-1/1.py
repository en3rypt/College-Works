import mysql.connector as sql


#create connection
mb = sql.connect(
  host="localhost",
  user="root",
  passwd="toor",
  database = "PSG",
  auth_plugin='mysql_native_password'
)
cur = mb.cursor()

#file handling
f = open('file.txt','r')
q = f.readlines()
l=[]
for i in q:
    l.append([j.strip('\t').strip('\n') for j in i.split(',')])

for i in l:
    print(i)

#date format
def get_date(s):
    x = s.split('-')
    y = int(x[-1])
    if(y>10):
        y+=1900
    else:
        y+=2000
    d = int(x[0])
    for j in range(len(m)):
        if m[j] == x[1].lower():
            mt = j
    dt = f"{y}-{mt}-{d}"
    return dt


#tbale creation
#cur.execute("CREATE TABLE EMPLOYEE(Empid varchar(4) ,Ename varchar(30) DEFAULT 'Ajay',DOB DATE NOT NULL,DOJ DATE NOT NULL,PRIMARY KEY(Empid)); ")
#mb.commit()
#print("Created table EMPLOYEE: ")
#print("CREATE TABLE EMPLOYEE(Empid varchar(4) ,Ename varchar(30) DEFAULT 'Ajay',DOB DATE NOT NULL,DOJ DATE NOT NULL,PRIMARY KEY(Empid));")
print("Insertions: ")
#insertion
didnt = []
m = ['','jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec']

for i in l:
    try:
        age = i[3]
        if age != 'null':
            age = int(age)
                
        s = f"INSERT INTO titanic VALUES('{i[0]}','{i[1]}','{i[2]}',{age},{int(i[4])},{float(i[5])},'{i[6]}','{i[7]}')"
        print(s)
        cur.execute(s)
        mb.commit()
        c+=1
    except:
        didnt.append(i)
        pass





for i in didnt:
    print(i)
#s = f'INSERT INTO titanic VALUES("{i[0]}","{i[1]}","{i[2]}",{int(i[3])},{int(i[4])},{float(i[5])},"{i[6]}","{i[7]}")'

'''
create table titanic
(
    lname varchar(25) not null,
    name varchar(100) primary key,
    gender char(1),
    check(gender in ('M','F')),
    age int,
    class int,
    fare float(9,4),
    check (fare>=5.00 and fare<=300.00),
    embarked varchar(25) not null,
    survived char(3) not null,
    check (survived in('yes','no'))
);
'''


'''
['Reuchlin', 'Jonkheer. John George', 'M', '38', '1', '0', 'Southampton', 'no', '']
['Fry', 'Mr. Richard', 'M', 'null', '1', '0', 'Southampton', 'no']
['Saundercock', 'Mr. William Henry', 'M', '20', '3', '8.05', 'Southampton', 'no']
'''
