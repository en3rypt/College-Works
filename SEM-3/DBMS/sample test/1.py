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
    d = int(x[0])
    for j in range(len(m)):
        if m[j] == x[1].lower():
            mt = j
    dt = f"{y}-{mt}-{d}"
    return dt


#tbale creation

print("Insertions: ")
#insertion
m = ['','jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec']
for i in l:
    dob = get_date(i[6])
    doj = get_date(i[7])
    
    s = f'INSERT INTO EMPLOYEE VALUES("{i[0]}","{i[1]}","{i[2]}",{i[3]},"{i[4]}","{i[5]}","{dob}","{doj}");'
    print(s)
    #cur.execute(s)
    #mb.commit()
    
    
