# Voice Expense Tracker 🧾🎙️

> A smart Flutter app that turns your spoken expenses into structured JSON using GPT-3.5, built to demonstrate AI-native mobile UX.

---

## 🚀 What It Does

Voice Expense Tracker allows users to **speak their daily expenses** in natural language (e.g.,
> “Spent ₹450 on Zomato today via UPI”)  
and instantly converts them into structured transaction data using **OpenAI’s GPT API**.

### 🎯 Extracted Output Includes:
- 💰 **Amount**
- 🏬 **Merchant**
- 📆 **Date**
- 💳 **Payment Type**
- 📂 **Expense Category**

---

## 📱 Demo

https://user-images.githubusercontent.com/your-demo-gif-here.gif  
*(or add screenshots later)*

---

## ⚙️ Tech Stack

- **Flutter (Dart)**
- **speech_to_text** – for live voice transcription
- **OpenAI GPT-3.5 API** – for NLP-based transaction parsing
- **http** – for API calls
- *(Upcoming: Hive or Shared Preferences for local persistence)*

---

## 📦 Folder Structure
lib/
├── screens/          # UI Screens (Home)
├── services/         # GPT & Speech services
├── models/           # Expense model (upcoming)
└── main.dart         # Entry point

---

## 🔐 API Key Setup

Replace `YOUR_OPENAI_API_KEY` in `gpt_service.dart` with your OpenAI key.  
(*Store it securely in production using `flutter_dotenv` or vault solutions.*)

---

## 🌟 Why This Project?

This app was built as a **real-world demonstration** of:
- 🧠 How AI (LLMs) can simplify mobile UX
- 🗣️ Using speech instead of forms for structured input
- 📱 Rapid prototyping of intelligent assistants on-device

---

## 📌 Author

**Perry Garg**  
AI-Powered Mobile Tech Lead (Android · Flutter · GPT APIs)  
[📧 perrygarg.1993@gmail.com](mailto:perrygarg.1993@gmail.com)  
[🔗 LinkedIn](https://linkedin.com/in/perrygarg)  
[💻 GitHub](https://github.com/perrygarg)

---

## ✅ Next Steps (Planned)

- [ ] Save parsed data locally
- [ ] Display expense list with filter
- [ ] Export/share expenses via CSV
- [ ] Add voice response using TTS