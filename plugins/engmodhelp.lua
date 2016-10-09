do

function run(msg, matches)
if msg.to.type == 'channel' and is_momod(msg) then
  return ''..[[
✔️لیست دستورات مدیریتی سوپر گروه:
🔱#info
〽️نمایش اطلاعات کلی در مورد سوپر گروه
🔱#setlang (fa,en)
〽️تعیین زبان گروه(fa=فارسی-en=انگلیسی)
🔱#who
〽️لیست کاربران گروه
🔱#me
〽️اطلاعاتی در باره شما در گروه
🔱#kmember
〽️حذف کاربر با فرستادن پیامی از او 
🔱#admins
〽️لیست مدیران گروه
🔱#modlist
〽️لیست مدیران ربات
🔱#kick @username
〽️اخراج کاربر از گروه با آیدی یا ریپلی
🔱#invite @username
〽️دعوت کاربر به گروه
🔱#ban @username
〽️بن کردن کاربر با آیدی یا ریپلی
🔱#unban
〽️خارج کردن کاربر از بن لیست با آیدی یا ریپلی
🔱#id
〽️نمایش آیدی شما و آیدی سوپر گروه
🔱#id from
〽️گرفتن آیدی از پیام فوروارد شده با ریپلی
🔱#promote @username
〽️ترفیع رتبه کاربر به عنوان مدیر گروه با آیدی یا ریپلی
🔱#demote @username
〽️تنزل‌ رتبه مدیر به ممبر معمولی گروه با آیدی یا ریپلی
🔱#setname (groupname)
〽️تعیین نام گروه
🔱#setphoto
〽️تعیین عکس گروه
🔱#newlink
〽️ساخت لینک جدید برای گروه
🔱#setlink
〽️نشاندن لینک برای گروه
(بعد از زدن دستور لینک گروه را ارسال کنید.)
🔱#link
〽️گرفتن لینک گروه
🔱#rules
〽️نمایش قوانین گروه
🔱#setrules text
〽️تعیین قوانین گروه
🔱#mute [all|audio|gifs|photo|video|service]
〽️صامت کردن 🔅همه 🔅صداها 🔅گیف ها 🔅عکس 🔅ویدیو 🔅سرویس
🔱#muteall Xh Ym Zs
〽️صامت کردن همه کاربران تا زمانی مشخص
مانند:!muteall 2h 12m 56s
🔱#unmute [all|audio|gifs|photo|video|service]
〽️خارج کردن از صامت
🔱#setflood [value]
〽️تنظیم حساسیت اسپم(جای [value] عددی بین 1-20قراردهید)
🔱#settings
〽️تنظیمات گروه
🔱#silent @username
〽️ساکت کردن کاربری با آیدی یا ریپلی
🔱#unsilent @username
〽️خارج کردن کاربر از لیست صامت با آیدی یا ریپلی
🔱#silentlist
〽️لیست افراد صامت شده
🔱#mutelist
〽️لیست افراد صامت
🔱#banlist
〽️لیست افراد بن شده
🔱#filterlist
〽️لیست کلمات فیلتر
🔱#mutelist
〽️لیست افراد صامت
🔱#clean [rules|about|modlist|silentlist|filterlist]
〽️پاک کردن 🔅قوانین 🔅اطلاعات 🔅لیست مدیران 🔅لیست کاربران صامت 🔅لیست کلمات فیلتر
🔱#clean msg [value]
〽️حذف پیام های اخیر گروه (جای value عددی بین 1-200)

✨توضیحات:

➰جای @username آیدی کاربر را قرار بدید.

➰با ریپلی یعنی بر روی پیام کاربر ریپلی(جواب دادن)کرده و دستور را وارد کنید.

➰در صامت کردن زمان دار بجای X ساعت بجای Y دقیقه و بجای Z ثانیه را قرار بدید. ]]
end
end
return {
  description = "Robot and Creator About", 
  usage = "/ver : robot info",
  patterns = {
    "^[!#/]modhelp$",
    
  }, 
  run = run 
}

end









