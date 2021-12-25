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
    l.append([j for j in i.split()])




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
cur.execute("CREATE TABLE EMPLOYEE(Empid varchar(4) ,Ename varchar(30) DEFAULT 'Ajay',DOB DATE NOT NULL,DOJ DATE NOT NULL,PRIMARY KEY(Empid)); ")
mb.commit()
print("Created table EMPLOYEE: ")
print("CREATE TABLE EMPLOYEE(Empid varchar(4) ,Ename varchar(30) DEFAULT 'Ajay',DOB DATE NOT NULL,DOJ DATE NOT NULL,PRIMARY KEY(Empid));")
print("Insertions: ")
#insertion
m = ['','jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec']
for i in l:
    dob = get_date(i[2])
    doj = get_date(i[3])
    s = f'INSERT INTO EMPLOYEE VALUES("{i[0]}","{i[1]}","{dob}","{doj}");'
    print(s)
    cur.execute(s)
    mb.commit()
    
    
