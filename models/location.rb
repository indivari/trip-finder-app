require 'pg'


def db_query(sql, params = [])
  
    conn = PG.connect(ENV['DATABASE_URL'] || {dbname: 'tripdb'})
    result = conn.exec_params(sql, params)
    conn.close
    return result
end

def all_locations()
    # db_query('select * from locations order by rating desc')
    db_query('select 
        locations.location_id,
        locations.name,
        locations.description,
        locations.image_url,
        average_rating as rating
        from 
            locations
            left join 
            (select 
                location_id, 
                avg(rating) as average_rating 
                from user_location_ratings
                group by location_id
            ) as sub_ratings
        on locations.location_id = sub_ratings.location_id
        order by rating desc')
end

def delete_location(id)
    sql = "delete from locations where location_id = $1;"

    db_query(sql, [id])
end

def check_email(email)
    sql = "select * from users where email = '#{email}'"
    db_query(sql)

end

def create_location(name,description,image_url,city)
    sql = "insert into locations (name, description,image_url,city) values($1,$2, $3,$4)"
  
    db_query(sql, [name,description,
    image_url, city])
end

def update_location(name,description,image_url,city,id)
    sql = "update locations set name=$1,description=$2,image_url=$3,city=$4
    where location_id=$5"

    db_query(sql, [name,description,image_url,city,id])
end

def city_locations(city_name)

    db_query('SELECT locations.location_id,locations.name,locations.description, locations.image_url, locations.city,avg(rating) as rating
     FROM locations,user_location_ratings 
     WHERE locations.location_id = user_location_ratings.location_id AND locations.city =$1
      GROUP BY locations.location_id order by rating desc',[city_name])

  
end
  