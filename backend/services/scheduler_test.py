import time
from datetime import datetime

from apscheduler.schedulers.background import BackgroundScheduler


def job():
    print(f"Job ran at {datetime.now()}")


# This scheduler runs jobs in the background using threads
scheduler = BackgroundScheduler()

scheduler.add_job(job, "interval", seconds=10)
scheduler.start()

try:
    while True:
        time.sleep(2)
except KeyboardInterrupt:
    scheduler.shutdown()
