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
cur.execute("CREATE TABLE EMPTABLE(Empid INT ,Name varchar(30) NOT NULL,City varchar(30),DOB DATE,Gender varchar(2),DOJ DATE,Salary float(10,2),Department varchar(20), CONSTRAINT Salary CHECK (Salary >=39000 and Salary<=200000), PRIMARY KEY(Empid)); ")
mb.commit()
#insertion
m = ['','jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec']
for i in l:
    dob = get_date(i[3])
    doj = get_date(i[5])
    s = f'INSERT INTO EMPTABLE VALUES({int(i[0])},"{i[1]}","{i[2]}","{dob}","{i[4]}","{doj}",{int(i[6])},"{i[7]}");'
    print(s)
    cur.execute(s)
    mb.commit()
    
    
