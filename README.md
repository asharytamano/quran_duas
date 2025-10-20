<p align="center">
  <img src="https://www.dropbox.com/scl/fi/9wddqrrcmhyh26ed74gfg/git_banner.png?rlkey=pcrrxvwp4n5evmyihttc1bgzi&dl=0" width="100%" alt="Qur'anic Duas App Banner"/>
</p>

# 🕋 Qur'anic Duas App
_A Heartfelt Collection of Supplications from the Holy Qur’an_


# 🕋 Qur'anic Duas App

A beautiful Flutter mobile app that compiles **all supplications (du‘ā)** found in the **Holy Qur’an**, organized by **Surah** and **theme** — presented in Arabic (Amiri font), English meaning, and transliteration.  
Whether you seek guidance, protection, forgiveness, or gratitude, this app gathers every heartfelt Qur’anic supplication in one easy-to-use collection.

---

## 🌙 Features

✨ **Beautiful Splash Screen**  
A gradient intro with Islamic patterns, the app logo, and a warm welcome message.

📖 **Comprehensive Dua Compilation**  
All Qur’anic duas, categorized by Surah and theme.

🔍 **Powerful Search**  
Find any dua by Arabic, transliteration, English meaning, or tags.

💖 **Favorites & Sharing**  
Save your most beloved duas and share them with others.

🌗 **Dark & Light Mode**  
Elegant themes with Amiri font for Arabic and Merriweather for English.

🕋 **Fully Offline**  
All data stored locally in `assets/data/duas.json` — no internet required.

---

## 🧩 Tech Stack

| Layer | Framework / Library |
|-------|----------------------|
| UI / App Framework | [Flutter](https://flutter.dev) (Material 3) |
| State Management | [Provider](https://pub.dev/packages/provider) |
| Sharing | [share_plus](https://pub.dev/packages/share_plus) |
| Icons & Fonts | Amiri (Arabic), Merriweather (English) |
| Design Language | Light/Dark theme with amber & green palette |

---

## 🗂 Folder Structure

lib/
├─ core/
│ ├─ theme.dart → App color scheme & typography
│ ├─ router.dart → Page routing
│ └─ utils.dart → JSON helpers
├─ models/
│ └─ dua.dart → Dua data model
├─ providers/
│ ├─ dua_provider.dart → Dua loading, search, favorites
│ └─ settings_provider.dart → Dark mode, text scale
├─ screens/
│ ├─ splash_intro_screen.dart
│ ├─ home_screen.dart
│ └─ dua_detail_screen.dart
└─ widgets/
├─ arabic_text.dart
├─ dua_card.dart
└─ header_logo.dart

---

## 🧾 Sample Data Format (`assets/data/duas.json`)

```json
[
  {
    "surah_number": 2,
    "surah_name_ar": "البقرة",
    "surah_name_en": "Al-Baqarah",
    "ayah": 201,
    "arabic": "رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ",
    "transliteration": "Rabbanā ātinā fid-dunyā ḥasanah wa fil-ākhirati ḥasanah wa qinā ʿadhāban-nār",
    "translation_en": "Our Lord, grant us good in this world and good in the Hereafter, and protect us from the punishment of the Fire.",
    "tags": ["protection", "comprehensive"]
  }
]

📸 Screenshots
Splash	Home (All Duas)

	
By Surah	Favorites

	
⚙️ How to Run
flutter pub get
flutter run


Tested on Flutter 3.24+, Material 3 enabled.

🧑‍💻 Author

Ashary Tamano
🌐 github.com/asharytamano

☪️ Acknowledgment

"And your Lord says: 'Call upon Me; I will respond to you.'"
— Surah Ghāfir (40:60)

This app is built with love and reverence, aiming to make Qur’anic supplications more accessible to every Muslim — for remembrance, reflection, and peace.

🪴 License

Released under the MIT License — free for all to use, modify, and share for the sake of knowledge and benefit.