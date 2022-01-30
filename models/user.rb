def db_query(sql, params = [])
    conn = PG.connect(ENV['DATABASE_URL'] || {dbname: 'tripdb'})
    result = conn.exec_params(sql, params)
    conn.close
    return result
end

def create_user(name,email,password_digest)
    sql = "insert into users(name,email,password_digest)
            values('#{name}','#{email}','#{password_digest}')"
    db_query(sql)
end