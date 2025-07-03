from contextlib import asynccontextmanager

from fastapi import FastAPI
from sqlmodel import SQLModel

from backend import models  # noqa: F401
from backend.config.settings import settings  # noqa: F401
from backend.database.db import engine
from backend.routes.auth import router as auth_router
from backend.routes.routes import router
from backend.routes.traffic import traffic_router


# TODO: create_all is for texting only, will be using alembic for production migrations
@asynccontextmanager
async def lifespan(app: FastAPI):
    from backend.services.scheduler import scheduler

    SQLModel.metadata.create_all(engine)

    try:
        scheduler.start()
        print("Scheduler Stared")  # TODO: for testing -> remove later
    except RuntimeError as e:
        print(f"Scheduler already started: {e}")

    yield

    scheduler.shutdown()


app = FastAPI(lifespan=lifespan)

app.include_router(router)
app.include_router(traffic_router)
app.include_router(auth_router)


@app.get("/health")
def health_check():
    return {"status": "OK"}


@app.get("/")
def root():
    return {"message": "Traffic Notifier API App is live."}
