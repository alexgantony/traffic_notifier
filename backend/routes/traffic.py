from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from twilio.rest import Client

from backend.config.settings import settings
from backend.database.db import get_session
from backend.models.models import Route
from backend.services.google_maps_services import get_eta_minutes

"""
    this file focuses on "actions" like traffic checking
"""

traffic_router = APIRouter()


# mock traffic check endpoint
@traffic_router.post("/routes/{route_id}/check", tags=["traffic"])
async def check_traffic_mock(route_id: int, session: Session = Depends(get_session)):
    route = session.get(Route, route_id)
    if not route:
        raise HTTPException(status_code=404, detail="Route not found")

    client = Client(settings.TWILIO_ACCOUNT_SID, settings.TWILIO_AUTH_TOKEN)

    eta_in_minutes = get_eta_minutes(route.source_address, route.destination_address)

    print(f"Source address: {route.source_address}")
    print(f"Destination address: {route.destination_address}")

    if eta_in_minutes > route.delay_threshold:
        if settings.TWILIO_ENABLED:
            message = client.messages.create(
                body=f"🚦 Delay detected: Current ETA is {eta_in_minutes} min. Your threshold is {route.delay_threshold} min.",
                from_=settings.TWILIO_PHONE_NUMBER,
                to=settings.TWILIO_RECEIVER_NUMBER,
            )
            sms_sent = True
            message_sid = message.sid
        else:
            sms_sent = False
            message_sid = "mock_sid"
    else:
        if settings.TWILIO_ENABLED:
            message = client.messages.create(
                body=f"No delay. ETA is {eta_in_minutes}. Route is clear",
                from_=settings.TWILIO_PHONE_NUMBER,
                to=settings.TWILIO_RECEIVER_NUMBER,
            )
            sms_sent = True
            message_sid = message.sid
        else:
            sms_sent = False
            message_sid = "mock_sid"

    return {
        "message": "Traffic check simulated",
        "route_id": route_id,
        "eta_in_minutes": eta_in_minutes,
        "delay_threshold": route.delay_threshold,
        "sms_sent": sms_sent,
        "message_sid": message_sid,
    }
