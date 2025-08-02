from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List

app = FastAPI(title="Python FastAPI Backend", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class User(BaseModel):
    id: int
    name: str
    email: str

sample_users = [
    User(id=1, name="田中太郎", email="tanaka@example.com"),
    User(id=2, name="佐藤花子", email="sato@example.com"),
    User(id=3, name="鈴木一郎", email="suzuki@example.com"),
    User(id=4, name="高橋美咲", email="takahashi@example.com"),
    User(id=5, name="渡辺健太", email="watanabe@example.com"),
    User(id=6, name="山田愛子", email="yamada@example.com"),
]

@app.get("/")
async def root():
    return {"message": "Hello from FastAPI Backend!"}

@app.get("/api/users", response_model=List[User])
async def get_users():
    return sample_users

@app.get("/api/users/{user_id}", response_model=User)
async def get_user(user_id: int):
    for user in sample_users:
        if user.id == user_id:
            return user
    return {"error": "User not found"}

@app.post("/api/users", response_model=User)
async def create_user(user: User):
    sample_users.append(user)
    return user

@app.get("/health")
async def health_check():
    return {"status": "healthy"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)