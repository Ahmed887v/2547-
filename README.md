# SpeakLocal — Learn to Speak English (Offline Android App)

SpeakLocal is a **Duolingo / ELSA-style** English speaking trainer that runs **locally on your Android phone**.

- Listen to phrases with on-device text-to-speech  
- Speak into the mic and get a **local pronunciation score**  
- Earn **XP**, keep a **streak**, and climb a lesson path  
- No account and no cloud API required for lessons or scoring  

**APK location after build:**  
`/home/testuser/Pics/Final_Project_Speak/build/app/outputs/flutter-apk/app-release.apk`  
(also copied to `SpeakLocal.apk` in this folder when the build finishes)

---

## App features

| Feature | What you get |
|--------|----------------|
| Learn tab | Daily XP goal, streak, hearts, next lesson |
| Path tab | Unit map like Duolingo (unlock lesson by lesson) |
| Practice | Listen → Speak → Score (ELSA-style drills) |
| Profile | Progress, refill hearts, reset local data |
| Content | 9 lessons · greetings, daily life, travel, work |

Arabic meanings are shown under each English phrase to help Arabic speakers.

---

## Install on an Android phone with USB debugging

### 1) On your phone — enable Developer options

1. Open **Settings → About phone**.  
2. Tap **Build number** 7 times until you see “You are now a developer”.  
3. Go back to **Settings → System → Developer options** (path may vary by brand).  
4. Turn on:
   - **USB debugging**
   - **Install via USB** (if shown)
   - On Xiaomi/Huawei/Oppo also allow **USB debugging (Security settings)** if present  

### 2) Connect the phone to this PC

1. Plug the phone in with a **data-capable** USB cable.  
2. On the phone, choose **File transfer / MTP** (not “Charge only”).  
3. Accept the **Allow USB debugging?** prompt (check “Always allow from this computer”).

### 3) Verify the connection

On the PC, open a terminal and run:

```bash
adb devices
```

You should see your device listed as `device` (not `unauthorized`).

If empty:

```bash
adb kill-server
adb start-server
adb devices
```

### 4) Install the APK

From this project folder:

```bash
cd /home/testuser/Pics/Final_Project_Speak
adb install -r SpeakLocal.apk
```

Or use the Flutter build output directly:

```bash
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

Success message looks like: `Success`

### 5) Open the app

1. Find **SpeakLocal** in the app drawer.  
2. On first mic use, allow **Microphone** permission.  
3. For best results install / enable an **English speech recognition** pack:
   - **Settings → System → Languages → Speech** (or **Google → Settings → Voice**)
   - Download **English (US)** offline speech if offered  

Device **Text-to-Speech** should already work with the built-in English voice.

---

## Rebuild the APK (optional)

```bash
export PATH="/home/testuser/flutter/bin:$PATH"
export ANDROID_HOME=/home/testuser/Android/Sdk
export ANDROID_SDK_ROOT=/home/testuser/Android/Sdk
export JAVA_HOME=/opt/android-studio/jbr

cd /home/testuser/Pics/Final_Project_Speak
flutter pub get
flutter build apk --release
cp -f build/app/outputs/flutter-apk/app-release.apk SpeakLocal.apk
```

---

## Wireless ADB (optional, after first USB pairing)

```bash
# Phone and PC on same Wi‑Fi; enable Wireless debugging on phone
adb pair <phone-ip>:<pairing-port>
adb connect <phone-ip>:<debug-port>
adb install -r SpeakLocal.apk
```

---

## Uninstall

```bash
adb uninstall com.speaklocal.speak_english
```

---

## Tips for speaking practice

1. Tap **Listen** before you speak.  
2. Speak clearly, one phrase at a time.  
3. Aim for **55%+** to mark a lesson complete.  
4. Hearts drop on weak attempts — refill from **Profile**.  
5. Practice daily to keep your streak.

---

## Project layout

```
Final_Project_Speak/
├── SpeakLocal.apk          # Ready-to-install release APK
├── README.md               # This guide
├── lib/                    # Flutter app source
│   ├── main.dart
│   ├── data/lessons.dart
│   ├── screens/
│   ├── services/
│   └── theme/
└── android/                # Android native project
```

**Package ID:** `com.speaklocal.speak_english`  
**Built with:** Flutter + Android SDK (local TTS + speech recognition)
