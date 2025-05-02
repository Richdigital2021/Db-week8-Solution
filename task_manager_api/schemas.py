 
from pydantic import BaseModel
from typing import Optional
from enum import Enum

class TaskStatus(str, Enum):
    pending = "pending"
    in_progress = "in_progress"
    completed = "completed"

class TaskCreate(BaseModel):
    title: str
    description: Optional[str] = None
    status: Optional[TaskStatus] = TaskStatus.pending
    user_id: Optional[int]

class TaskRead(TaskCreate):
    id: int
    class Config:
        orm_mode = True

class UserCreate(BaseModel):
    name: str
    email: str

class UserRead(UserCreate):
    id: int
    class Config:
        orm_mode = True
