import requests

from backend.config.settings import settings


def get_eta_minutes(source: str, destination: str) -> int:
    distance_matrix_url = (
        f"https://maps.googleapis.com/maps/api/distancematrix/json?"
        f"origins={source}&destinations={destination}&key={settings.GOOGLE_MAPS_API_KEY}"
    )

    r = requests.get(url=distance_matrix_url)
    data = r.json()
    element = data["rows"][0]["elements"][0]

    if element.get("status") != "OK":
        raise Exception(f"Google API returned error: {element}")

    eta = element["duration"]["value"] // 60
    return eta
