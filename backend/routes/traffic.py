from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from twilio.rest import Client

from backend.config.settings import settings
from backend.database.db import get_session
from backend.models.models import Route

"""
    this file focuses on "actions" like traffic checking
"""

traffic_router = APIRouter()


# mock traffic check endpoint
@traffic_router.post("/routes/{route_id}/check", tags=["traffic"])
async def check_traffic_mock(route_id: int, session: Session = Depends(get_session)):
    route = session.get(Route, route_id)
    client = Client(settings.TWILIO_ACCOUNT_SID, settings.TWILIO_AUTH_TOKEN)
    # TODO: replace fake_eta with Google Maps ETA
    fake_eta = 25

    if not route:
        raise HTTPException(status_code=404, detail="Route not found")

    print(f"Source address: {route.source_address}")
    print(f"Destination address: {route.destination_address}")

    if fake_eta > route.delay_threshold:
        sms_needed = True
        message = client.messages.create(
            body=f"🚦 Delay detected: Current ETA is {fake_eta} min. Your threshold is {route.delay_threshold} min.",
            from_=settings.TWILIO_PHONE_NUMBER,
            to=settings.TWILIO_RECEIVER_NUMBER,
        )
    else:
        sms_needed = False
        message = client.messages.create(
            body=f"No delay. ETA is {fake_eta}. Route is clear",
            from_=settings.TWILIO_PHONE_NUMBER,
            to=settings.TWILIO_RECEIVER_NUMBER,
        )

    return {
        "message": "Traffic check simulated",
        "route_id": route_id,
        "eta_in_minutes": fake_eta,
        "delay_threshold": route.delay_threshold,
        "sms_sent": sms_needed,
        "message_sid": message.sid,
    }
