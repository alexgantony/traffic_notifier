from fastapi import APIRouter, Body, Depends, HTTPException, Response
from sqlmodel import Session, select

from backend.database.db import get_session
from backend.models import Route
from backend.schemas.route import RouteCreate, RouteOut, RouteUpdate

router = APIRouter()

# TODO: Remove this
"""
    this file contains APIRouter file i.e, endpoints definition
"""
# TODO: Add logs


# create a new commute route
@router.post("/routes/", response_model=RouteOut)
async def create_route(route_in: RouteCreate, session: Session = Depends(get_session)):
    db_route = Route(**route_in.model_dump())
    # Insert into database
    session.add(db_route)
    #  Saves to DB
    session.commit()
    # Reloads updated fields
    session.refresh(db_route)
    return db_route


# fetch all routes
@router.get("/routes/", response_model=list[RouteOut])
async def list_routes(session: Session = Depends(get_session)):
    # select * from route
    statement = select(Route)
    # execute the SQL Query
    results = session.exec(statement)
    # fetching all results as a list of Route objects
    route = results.all()
    return route


# fetch a specific route by ID
@router.get("/routes/{route_id}", response_model=RouteOut)
async def get_route(route_id: int, session: Session = Depends(get_session)):
    route = session.get(Route, route_id)
    if not route:
        raise HTTPException(status_code=404, detail="Route not found")
    return route


# update selected route fields
@router.patch("/routes/{route_id}", response_model=RouteOut)
async def update_route(
    route_id: int,
    route_in: RouteUpdate = Body(...),
    session: Session = Depends(get_session),
):
    # .get() Fetching using primary key in the 'Route' model
    db_route = session.get(Route, route_id)
    if not db_route:
        raise HTTPException(status_code=404, detail="Route not found")

    route_data = route_in.model_dump(exclude_unset=True)
    for k, v in route_data.items():
        setattr(db_route, k, v)

    session.add(db_route)
    session.commit()
    session.refresh(db_route)
    return db_route


# delete a route by ID
@router.delete("/routes/{route_id}", response_model=RouteOut)
async def delete_route(route_id: int, session: Session = Depends(get_session)):
    route = session.get(Route, route_id)
    if not route:
        raise HTTPException(status_code=404, detail="Route not found")

    session.delete(route)
    session.commit()
    return Response(status_code=204)


# TODO: Implement traffic log fetching after v0.01 demo
# This route will return historical traffic check logs (ETA, route, timestamp, etc.)
# Useful for debugging or showing users past route checks
# # read logs
# @router.get("/logs/", tags=["logs"])
# async def read_logs():
#     TODO: Replace with actual DB query to return traffic logs
#     return {"message": "Logs Fetched"}
