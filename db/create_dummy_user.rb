
require 'pg'
require 'bcrypt'
#
puts "creating dummy user"
#connect to db
#exec an insert statement to create a new user

# hard code the email and password
email = "indivarij@gmail.com"
password = "abc"

password_digest = BCrypt::Password.create(password)

conn = PG.connect(dbname: 'tripdb')
sql = "insert into users (name,email, password_digest) values ('indi','#{email}','#{password_digest}');"

conn.exec(sql)
conn.close

puts "done"