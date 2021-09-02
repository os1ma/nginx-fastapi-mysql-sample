from fastapi import FastAPI
import MySQLdb

app = FastAPI()


@app.get("/api/posts")
async def posts():
    con = MySQLdb.connect(
        user='app',
        passwd='password',
        host='db',
        db='app',
        charset="utf8")

    cur= con.cursor()
    sql = "select id, message, created_at from posts order by id"
    cur.execute(sql)
    rows = cur.fetchall()

    posts = []
    for row in rows:
        post = {
            'id': row[0],
            'message': row[1],
            'createdAt': row[2]
        }
        posts.append(post)

    cur.close()
    con.close()

    return {"posts": posts}
