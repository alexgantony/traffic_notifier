from contextlib import asynccontextmanager

from fastapi import FastAPI
from sqlmodel import SQLModel

from backend import models  # noqa: F401
from backend.database.db import engine


# TODO: create_all is for texting only, will be using alembic for production migrations
@asynccontextmanager
async def lifespan(app: FastAPI):
    SQLModel.metadata.create_all(engine)
    yield


app = FastAPI(lifespan=lifespan)


@app.get("/health")
def health_check():
    return {"status": "OK"}


@app.get("/")
def root():
    return {"message": "Traffic Notifier API App is live."}
