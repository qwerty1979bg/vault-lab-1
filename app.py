#!/usr/bin/python

import MySQLdb

db = MySQLdb.connect(	host="localhost",	# localhost, for now
			user="test",		# hardcoded username - #YOLO
#			passwd="pass")		# hardcoded password
			passwd="pass",		# hardcoded password
			db="world")		# database name 

# This comes straight from some tutorial - will need to be modified accordingly

# you must create a Cursor object. It will let
#  you execute all the queries you need
cur = db.cursor()

# Use all the SQL you like
#cur.execute("CREATE DATABASE test123")
cur.execute("SELECT name FROM city where countrycode='BGR'")

# print all the first cell of all the rows
for row in cur.fetchall():
    print row[0]

db.close()
