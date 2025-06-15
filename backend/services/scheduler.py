from apscheduler.schedulers.background import BackgroundScheduler

from backend.services.scheduler_jobs import check_scheduled_routes

scheduler = BackgroundScheduler()
scheduler.add_job(check_scheduled_routes, trigger="interval", minutes=1)
