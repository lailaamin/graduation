import pymysql
import json
import numpy as np
from bson import *

class Database:

    def __init__(self):
        self.connection = pymysql.connect( host='localhost', port=3307, user='root', passwd='', db='heartattackprediction')
        self.cur = self.connection.cursor()

    def select(self, query):
        self.cur.execute(query)
        row_headers = [x[0] for x in self.cur.description]  # this will extract row headers
        rv = self.cur.fetchall()
        json_data = []
        for result in rv:
            json_data.append(dict(zip(row_headers, result)))
        return json.dumps(json_data , default=str)

    def insert(self, query):
        try:
            self.cur.execute(query)
            self.connection.commit()
        except:
            self.connection.rollback()

    def Update(self,query):
        try:
            self.cur.execute(query)
            self.connection.commit()
        except:
            self.connection.rollback()

    def Delete(self, query):
        try:
            self.cur.execute(query)
            self.connection.commit()
        except:
            self.connection.rollback()

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.connection:
          self.connection.close()



d=Database()
sql="SELECT * FROM location"
select=d.select(sql)

print(select)


# sql1="INSERT INTO sensorreading (Value) VALUES (300)"
# insert=d.insert(sql1)

# sql2="DELETE FROM sensorreading WHERE ID=4"
# d.Delete(sql2)

# sql3="UPDATE sensorreading SET Value=300 WHERE ID=2"
# d.Update(sql3)