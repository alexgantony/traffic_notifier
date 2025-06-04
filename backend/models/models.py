from datetime import datetime, timezone
from typing import Optional

from sqlalchemy import Column, String
from sqlmodel import Field, SQLModel


class User(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    email: str = Field(sa_column=Column("email", String, unique=True, nullable=False))
    hashed_password: str = Field(nullable=False)
    created_at: datetime = Field(
        default_factory=lambda: datetime.now(timezone.utc), nullable=False
    )


class Route(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    source_address: str = Field(nullable=False)
    destination_address: str = Field(nullable=False)
    route_label: str = Field(default="", max_length=50)
    traffic_check_time: datetime = Field(
        default_factory=lambda: datetime.now(timezone.utc), nullable=True
    )
    delay_threshold: int = Field(nullable=False)
    created_at: datetime = Field(
        default_factory=lambda: datetime.now(timezone.utc), nullable=False
    )
    user_id: int | None = Field(default=None, foreign_key="user.id", index=True)


class TrafficLog(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    eta_in_minutes: int = Field(nullable=False)
    route_id: int = Field(foreign_key="route.id", index=True)
    user_id: int = Field(foreign_key="user.id", index=True)
    created_at: datetime = Field(
        default_factory=lambda: datetime.now(timezone.utc), nullable=False
    )
