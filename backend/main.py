from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def root():
    return {"Message: Traffic Notifier API App is live."}
