import MySQLdb
from fastapi import FastAPI, status
from fastapi.responses import JSONResponse
from pydantic import BaseModel

app = FastAPI()


@app.get("/api/posts")
async def list_posts():
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

class PostPostRequestBody(BaseModel):
    message: str

@app.post("/api/posts")
async def post_posts(body: PostPostRequestBody):
    con = MySQLdb.connect(
        user='app',
        passwd='password',
        host='db',
        db='app',
        charset="utf8")

    cur= con.cursor()
    sql = "insert into posts (message) values (%s)"
    cur.execute(sql, (body.message,))
    cur.close()

    con.commit()
    con.close()

    return JSONResponse(status_code=status.HTTP_201_CREATED)
