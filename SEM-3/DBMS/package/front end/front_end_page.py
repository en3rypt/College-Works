import cx_Oracle

connection = cx_Oracle.connect(
    user="SYSTEM",
    password="test123",
    dsn="localhost/xepdb1")

print("Successfully connected to Oracle Database")

cursor = connection.cursor()

for row in cursor.execute('select * from ride'):
    print(row)