from fastapi import APIRouter

router = APIRouter()

# TODO: Remove this
"""
    this file contains APIRouter file i.e, endpoints definition
"""
# TODO: Add logs


# add new route
@router.post("/routes/")
async def add_new_route():
    return {"message": "Add new route created"}


# get all routes
@router.get("/routes/")
async def get_all_routes():
    return {"message": "getting all routes"}


# get a route
@router.get("/routes/{id}")
async def get_route(id):
    return {"message": f"Route for id: {id}"}


# update a route
@router.patch("/routes/{id}")
async def update_route(id):
    return {"message": f"Route {id} updated"}


# delete a route
@router.delete("/routes/{id}")
async def delete_route(id):
    return {"message": f"Route {id} deleted"}


# read logs
@router.get("/logs/", tags=["logs"])
async def read_logs():
    return {"message": "Logs Fetched"}
