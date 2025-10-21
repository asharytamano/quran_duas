import json
from pathlib import Path

DUAS_JSON = Path("assets/data/duas.json")

def pad(num, length=3):
    return str(num).zfill(length)

def update_audio_fields():
    with open(DUAS_JSON, "r", encoding="utf-8") as f:
        duas = json.load(f)

    updated = 0
    for dua in duas:
        surah = dua["surah_number"]
        ayah = dua["ayah"]
        new_audio = f"{pad(surah)}{pad(ayah)}.mp3"

        # Update audio field if it's different
        if dua.get("audio") != new_audio:
            dua["audio"] = new_audio
            updated += 1

    # Save back to file
    with open(DUAS_JSON, "w", encoding="utf-8") as f:
        json.dump(duas, f, ensure_ascii=False, indent=2)

    print(f"✅ Updated {updated} audio fields successfully!")

if __name__ == "__main__":
    update_audio_fields()
