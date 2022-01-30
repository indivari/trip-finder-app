require 'pg'

def db_query(sql, params = [])
    conn = PG.connect(ENV['DATABASE_URL'] || {dbname: 'tripdb'})
    result = conn.exec_params(sql, params)
    conn.close
    return result
end

def create_or_update_rating(user_id, location_id, rating)
    result = db_query('select * from user_location_ratings where user_id = $1 and location_id = $2', [ user_id, location_id])

    if result.count > 0
        # update
        sql = "update user_location_ratings set rating=$3 where user_id = $1 and location_id = $2"
    elsif
        # insert
        sql = "insert into user_location_ratings (user_id, location_id, rating) values($1, $2, $3)"
    end
    
    db_query(sql, [user_id, location_id, rating])
end

# def update_location(name,description,image_url,city,id)
#     sql = "update locations set name=$1,description=$2,image_url=$3,city=$4
#     where location_id=$5"

#     db_query(sql, [name,description,image_url,city,id])
# end
  