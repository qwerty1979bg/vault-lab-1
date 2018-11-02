#!/usr/bin/python

#import os
import MySQLdb
import subprocess

# Get the MySQL credentials from the OS ENV variables
#username='%s' %os.environ['mysql_username']		# get DB username from ENV VAR
#password='%s' %os.environ['mysql_password']		# get DB username from ENV VAR

# Get the MySQL credentials from Vault
# TODO replace this to use Vault API
username=subprocess.check_output(['vault', 'kv', 'get', '-field=user', 'secret/mysql'])
password=subprocess.check_output(['vault', 'kv', 'get', '-field=password', 'secret/mysql'])

db = MySQLdb.connect(	host="localhost",	# localhost, for now
			user='%s' %username,
			passwd='%s' %password,
			db="world")		# database name 

# This comes straight from some tutorial - will need to be modified accordingly

# you must create a Cursor object. It will let
#  you execute all the queries you need
cur = db.cursor()

# Use all the SQL you like
cur.execute("SELECT name FROM city where countrycode='BGR'")

# print all the first cell of all the rows
for row in cur.fetchall():
    print row[0]

db.close()