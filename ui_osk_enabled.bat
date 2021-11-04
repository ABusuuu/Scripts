taskkill /IM firefox.exe /f

cd /D "%APPDATA%\Mozilla\Firefox\Profiles\*.default"

set ffile=%cd%
echo user_pref("ui.osk.debug.keyboardDisplayReason", "AIOSKIDM: regkey value=true.");>>"%ffile%\user.js"
echo user_pref("ui.osk.detect_physical_keyboard", false);>>"%ffile%\user.js"
echo user_pref("ui.osk.enabled", true);>>"%ffile%\user.js"
echo user_pref("ui.osk.on_screen_keyboard_path", "\"C:\\Program Files\\Common Files\\microsoft shared\\ink\\TabTip.exe\"");>>"%ffile%\user.js"
echo user_pref("ui.osk.require_tablet_mode", false);>>"%ffile%\user.js"

set ffile=

cd %windir%

cd /D "%APPDATA%\Mozilla\Firefox\Profiles\*.default-release"

set ffile=%cd%
echo user_pref("ui.osk.debug.keyboardDisplayReason", "AIOSKIDM: regkey value=true.");>>"%ffile%\user.js"
echo user_pref("ui.osk.detect_physical_keyboard", false);>>"%ffile%\user.js"
echo user_pref("ui.osk.enabled", true);>>"%ffile%\user.js"
echo user_pref("ui.osk.on_screen_keyboard_path", "\"C:\\Program Files\\Common Files\\microsoft shared\\ink\\TabTip.exe\"");>>"%ffile%\user.js"
echo user_pref("ui.osk.require_tablet_mode", false);>>"%ffile%\user.js"

set ffile=

cd %windir%

cd /D "C:\Program Files\Mozilla Firefox"
firefox.exe
