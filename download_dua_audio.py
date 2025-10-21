import json
import requests
from pathlib import Path

# === CONFIGURATION ===
DUAS_JSON = Path("assets/data/duas.json")   # Path to your duas.json file
AUDIO_DIR = Path("assets/audio")            # Output folder for MP3 files
AUDIO_DIR.mkdir(parents=True, exist_ok=True)

# ✅ EveryAyah base URL (Hani Rifai, 192kbps)
BASE_URL = "https://everyayah.com/data/Hani_Rifai_192kbps"

TIMEOUT = 20  # seconds

def pad(num, length=3):
    """Return a zero-padded number (e.g., 1 -> '001')."""
    return str(num).zfill(length)

def download_dua_audio():
    # Load duas.json
    with open(DUAS_JSON, "r", encoding="utf-8") as f:
        duas = json.load(f)

    print(f"📜 Total duas found: {len(duas)}")

    for dua in duas:
        surah = dua["surah_number"]
        ayah = dua["ayah"]

        # ✅ Build filename dynamically: 001005.mp3
        filename = f"{pad(surah)}{pad(ayah)}.mp3"
        file_path = AUDIO_DIR / filename
        url = f"{BASE_URL}/{filename}"

        # Skip if already exists
        if file_path.exists():
            print(f"✅ Skipping (exists): {filename}")
            continue

        try:
            print(f"⬇️  Downloading: {filename} ... ", end="")
            response = requests.get(url, timeout=TIMEOUT)
            response.raise_for_status()

            with open(file_path, "wb") as out:
                out.write(response.content)

            print("done.")
        except requests.RequestException as e:
            print(f"❌ failed ({e})")

    print("\n✅ All downloads complete!")
    print(f"📁 Saved in: {AUDIO_DIR.resolve()}")

if __name__ == "__main__":
    download_dua_audio()
