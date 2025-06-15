from datetime import datetime, time

from sqlmodel import SQLModel

# TODO: Remove This
"""
This file contains request/response model (Pydantic / SQLModel but without table=True)
------
RouteBase (optional, shared fields)

RouteCreate (input)

RouteOut (output)

RouteUpdate (partial update; fields optional)
-----

"""


class RouteBase(SQLModel):
    source_address: str
    destination_address: str
    route_label: str | None = (
        None  # TODO: REMOVE THE COMMENT. this None = None is to make the field optional.
    )
    traffic_check_time: datetime | None = None
    delay_threshold: int
    alert_time: time | None = None


# Create a new route
class RouteCreate(RouteBase):
    # TODO: Remove these comments
    # REQUEST BODY SCHEMA
    # sent from the client to fastAPI backend (my app)
    # when the user create a new route
    # Contains only user supplied fields
    # backend then uses those values (plus the authenticated user_id) to call Google Maps for ETA checks or to store the route in the DB.
    pass
    # RouteCreate → only client-supplied data, no server-generated fields.


class RouteOut(RouteBase):
    # TODO: Remove these comments
    #  RESPONSE SCHEMA
    # Sent from your FastAPI backend → back to the client after the route has been created (or fetched).
    # Includes everything in RouteBase plus server-generated fields like id and created_at.
    # The Google Maps call is internal; the client only receives the validated response shaped by RouteOut.
    id: int
    created_at: datetime
    # RouteOut → everything the client needs to see after creation, which includes the DB-assigned id and server timestamp.


class RouteUpdate(RouteBase):
    # TODO: Remove these comments
    source_address: str | None = None
    destination_address: str | None = None
    route_label: str | None = (
        None  # TODO: REMOVE THE COMMENT. this None = None is to make the field optional.
    )
    traffic_check_time: datetime | None = None
    delay_threshold: int | None = None
    alert_time: time | None = None
