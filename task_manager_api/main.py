from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from database import SessionLocal, engine, Base
from dotenv import load_dotenv  # ✅ This import was missing
import models, schemas

load_dotenv()  # ✅ This now works
Base.metadata.create_all(bind=engine)


app = FastAPI()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Create User
@app.post("/users", response_model=schemas.UserRead)
def create_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    db_user = models.User(**user.dict())
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

# Create Task
@app.post("/tasks", response_model=schemas.TaskRead)
def create_task(task: schemas.TaskCreate, db: Session = Depends(get_db)):
    db_task = models.Task(**task.dict())
    db.add(db_task)
    db.commit()
    db.refresh(db_task)
    return db_task

# Get All Tasks
@app.get("/tasks", response_model=list[schemas.TaskRead])
def get_tasks(db: Session = Depends(get_db)):
    return db.query(models.Task).all()

# Get Task by ID
@app.get("/tasks/{task_id}", response_model=schemas.TaskRead)
def get_task(task_id: int, db: Session = Depends(get_db)):
    task = db.query(models.Task).get(task_id)
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")
    return task

# Update Task
@app.put("/tasks/{task_id}", response_model=schemas.TaskRead)
def update_task(task_id: int, updated: schemas.TaskCreate, db: Session = Depends(get_db)):
    task = db.query(models.Task).get(task_id)
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")
    for field, value in updated.dict().items():
        setattr(task, field, value)
    db.commit()
    db.refresh(task)
    return task

# Delete Task
@app.delete("/tasks/{task_id}")
def delete_task(task_id: int, db: Session = Depends(get_db)):
    task = db.query(models.Task).get(task_id)
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")
    db.delete(task)
    db.commit()
    return {"message": "Task deleted successfully"}

from sqlalchemy import text  # Add this import at the top

@app.get("/ping-db")
def ping_db(db: Session = Depends(get_db)):
    try:
        db.execute(text("SELECT 1"))
        return {"status": "Database connected"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

