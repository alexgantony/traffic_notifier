import requests

from backend.config.settings import settings


def get_eta_minutes(source: str, destination: str) -> int:
    distance_matrix_url = (
        f"https://maps.googleapis.com/maps/api/distancematrix/json?"
        f"origins={source}&destinations={destination}&key={settings.GOOGLE_MAPS_API_KEY}"
    )

    r = requests.get(url=distance_matrix_url)
    data = r.json()
    eta = data["rows"][0]["elements"][0]["duration"]["value"] // 60
    return eta


if __name__ == "__main__":
    print(get_eta_minutes("Kochi", "Thrissur"))
