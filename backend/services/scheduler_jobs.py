from contextlib import contextmanager
from datetime import datetime

from sqlmodel import select

from backend.config.settings import settings
from backend.database.db import get_session
from backend.models.models import Route, TrafficLog
from backend.services.google_maps_services import get_eta_minutes


@contextmanager
def session_context():
    session = next(get_session())
    try:
        yield session
    finally:
        session.close()


def check_scheduled_routes():
    now = datetime.now().time()

    with session_context() as session:
        routes = session.exec(select(Route)).all()

        for route in routes:
            if (
                route.alert_time is not None
                and route.alert_time.hour == now.hour
                and route.alert_time.minute == now.minute
            ):
                eta = get_eta_minutes(route.source_address, route.destination_address)
                print(f"ETA for route {route.route_label}: {eta}")

                is_delayed = eta > route.delay_threshold

                traffic_log = TrafficLog(
                    route_id=route.id,
                    eta_in_minutes=eta,
                    delay_threshold=route.delay_threshold,
                    is_delayed=is_delayed,
                    sms_sent=settings.TWILIO_ENABLED,
                )
                session.add(traffic_log)
                session.commit()

                print(
                    f"Logged traffic for route {route.route_label}, delayed={is_delayed}"
                )
