
do

--------------------------
local function clean_msg(extra, suc, result)
  for i=1, #result do
    delete_msg(result[i].id, ok_cb, false)
  end
  if tonumber(extra.con) == #result then
    send_msg(extra.chatid, ''..#result..' پیام اخیر گروه حذف شد', ok_cb, false)
  else
    send_msg(extra.chatid, 'Error Deleting messages', ok_cb, false)  
end 
end
-----------------------
local function topng(msg, success, result)
  local receiver = get_receiver(msg)
  if success then
    local file = './data/topng/'..msg.from.id..'.png'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    send_document(get_receiver(msg), file, ok_cb, false)
    redis:del("photo:png")
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end
-----------------------
local function toaudio(msg, success, result)
  local receiver = get_receiver(msg)
  if success then
    local file = './data/toaudio/'..msg.from.id..'.mp3'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    send_audio(get_receiver(msg), file, ok_cb, false)
    redis:del("video:audio")
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end
-----------------------

local function tomkv(msg, success, result)
  local receiver = get_receiver(msg)
  if success then
    local file = './data/tomkv/'..msg.from.id..'.mkv'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    send_document(get_receiver(msg), file, ok_cb, false)
    redis:del("video:document")
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end
-----------------------

local function togif(msg, success, result) 
  local receiver = get_receiver(msg) 
  if success then 
    local file = './data/togif/'..msg.from.id..'.mp4' 
    print('File downloaded to:', result) 
    os.rename(result, file) 
    print('File moved to:', file) 
    send_document(get_receiver(msg), file, ok_cb, false) 
    redis:del("video:gif") 
  else 
    print('Error downloading: '..msg.id) 
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false) 
  end 
end 
-----------------------
local function tovideo(msg, success, result)
  local receiver = get_receiver(msg)
  if success then
    local file = './data/tovideo/'..msg.from.id..'.gif'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    send_video(get_receiver(msg), file, ok_cb, false)
    redis:del("gif:video")
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end
-----------------------
local function toimage(msg, success, result)
  local receiver = get_receiver(msg)
  if success then
    local file = './data/tophoto/'..msg.from.id..'.jpg'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    send_photo(get_receiver(msg), file, ok_cb, false)
    redis:del("sticker:photo")
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end
-----------------------
local function tosticker(msg, success, result)
  local receiver = get_receiver(msg)
  if success then
    local file = './data/tosticker/'..msg.from.id..'.webp'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    send_document(get_receiver(msg), file, ok_cb, false)
    redis:del("photo:sticker")
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end

------------------------
local function get_weather(location)
  print("Finding weather in ", location)
  local BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
  local url = BASE_URL
  url = url..'?q='..location..'&APPID=eedbc05ba060c787ab0614cad1f2e12b'
  url = url..'&units=metric'
  local b, c, h = http.request(url)
  if c ~= 200 then return nil end

   local weather = json:decode(b)
   local city = weather.name
   local country = weather.sys.country
   local temp = 'دمای شهر '..city..' هم اکنون '..weather.main.temp..' درجه سانتی گراد می باشد\n____________________'
   local conditions = 'شرایط فعلی آب و هوا : '

   if weather.weather[1].main == 'Clear' then
     conditions = conditions .. 'آفتابی☀'
   elseif weather.weather[1].main == 'Clouds' then
     conditions = conditions .. 'ابری ☁☁'
   elseif weather.weather[1].main == 'Rain' then
     conditions = conditions .. 'بارانی ☔'
   elseif weather.weather[1].main == 'Thunderstorm' then
     conditions = conditions .. 'طوفانی ☔☔☔☔'
 elseif weather.weather[1].main == 'Mist' then
     conditions = conditions .. 'مه 💨'
  end

  return temp .. '\n' .. conditions
end
--------------------------
local function calc(exp)
   url = 'http://api.mathjs.org/v1/'
  url = url..'?expr='..URL.escape(exp)
   b,c = http.request(url)
   text = nil
  if c == 200 then
    text = 'Result = '..b..'\n_____________________'
  elseif c == 400 then
    text = b
  else
    text = 'Unexpected error\n'
      ..'Is api.mathjs.org up?'
  end
  return text
end
--------------------------
function run(msg, matches) 
	 --------------------------
  if matches[1] == 'clean' and matches[2] == "msg" and is_momod(msg) or matches[1] == 'حدف' and matches[2] == "پیام ها" and is_momod(msg) or matches[1] == 'rm' and matches[2] == "sg" and is_momod(msg) then
    if msg.to.type == "user" then 
      return 
      end
    if msg.to.type == 'chat' then
      return  "Only in the Super Group" 
      end
    if not is_momod(msg) then 
      return "》You Are Not Allow To clean Msgs!\n》شما مدیر ربات نیستید"
      end
    if tonumber(matches[3]) > 200 or tonumber(matches[3]) < 1 then
      return "》maximum clean is 200\n》حداکثر تا 200 پیام قابل حذف است."
      end
   get_history(msg.to.peer_id, matches[3] + 1 , clean_msg , { chatid = msg.to.peer_id,con = matches[3]})
   end
  --------------------------
    if matches[1] == 'addplugin' and is_sudo(msg) then
        if not is_sudo(msg) then
           return "You Are Not Allow To Add Plugin"
           end
   name = matches[2]
   text = matches[3]
   file = io.open("./plugins/"..name, "w")
   file:write(text)
   file:flush()
   file:close()
   return "Add plugin successful "
end
------------------------
 if matches[1] == "mean" and is_momod(msg) or matches[1] == "معنی" and is_momod(msg) then
 http = http.request('http://api.vajehyab.com/v2/public/?q='..URL.escape(matches[2]))
   data = json:decode(http)
	return 'واژه : '..(data.data.title or data.search.q)..'\n\nترجمه : '..(data.data.text or '----' )..'\n\nمنبع : '..(data.data.source or '----' )..'\n\n'..(data.error.message or '')..'\n..\n____________________'
end
   --------------------------
      if matches[1] == "dl" and matches[2] == "plugin" and is_sudo(msg) then
     if not is_sudo(msg) then
    return "You Are Not Allow To Download Plugins!"
  end
   receiver = get_receiver(msg)
      send_document(receiver, "./plugins/"..matches[3]..".lua", ok_cb, false)
      send_document(receiver, "./plugins/"..matches[3], ok_cb, false)
    end
    --------------------------
if matches[1] == "calc" and is_momod(msg) or matches[1] == "ماشین حساب" and is_momod(msg) and matches[2] and is_sudo(msg) then 
    if msg.to.type == "user" then 
       return 
       end
    return calc(matches[2])
end
--------------------------
if matches[1] == 'weather' and is_momod(msg) or matches[1] == 'هواشناسی' and is_momod(msg) then
    city = matches[2]
  local wtext = get_weather(city)
  if not wtext then
    wtext = 'مکان وارد شده صحیح نیست'
  end
  return wtext
end
---------------------
if matches[1] == 'time' and is_momod(msg) or matches[1] == 'زمان' and is_momod(msg) then
local url , res = http.request('http://api.gpmod.ir/time/')
if res ~= 200 then
 return "No connection"
  end
  local colors = {'blue','green','yellow','magenta','Orange','DarkOrange','red'}
  local fonts = {'mathbf','mathit','mathfrak','mathrm'}
local jdat = json:decode(url)
local url = 'http://latex.codecogs.com/png.download?'..'\\dpi{600}%20\\huge%20\\'..fonts[math.random(#fonts)]..'{{\\color{'..colors[math.random(#colors)]..'}'..jdat.ENtime..'}}'
local file = download_to_file(url,'time.webp')
send_document(get_receiver(msg) , file, ok_cb, false)

end
--------------------
if matches[1] == 'voice' and is_momod(msg) or matches[1] == 'وویس' and is_momod(msg) then
 local text = matches[2]

  local b = 1

  while b ~= 0 do
    textc = text:trim()
    text,b = text:gsub(' ','.')
    
    
  if msg.to.type == 'user' then 
      return nil
      else
  local url = "http://tts.baidu.com/text2audio?lan=en&ie=UTF-8&text="..textc
  local receiver = get_receiver(msg)
  local file = download_to_file(url,'mohamad.ogg')
 send_audio('channel#id'..msg.to.id, file, ok_cb , false)
end
end
end
------------------------
 local receiver = get_receiver(msg)
    local group = msg.to.id
    if msg.reply_id then
       if msg.to.type == 'document' and redis:get("sticker:photo") then
        if redis:set("sticker:photo", "waiting") then
        end
       end
    
      if matches[1]:lower() == "photo" and is_momod(msg) or matches[1] == 'عکس' and is_momod(msg) then
     redis:get("sticker:photo")
    send_large_msg(receiver, '', ok_cb, false)
        load_document(msg.reply_id, toimage, msg)
    end
end
------------------------
	    local receiver = get_receiver(msg)
    local group = msg.to.id
    if msg.reply_id then
       if msg.to.type == 'photo' and redis:get("photo:sticker") then
        if redis:set("photo:sticker", "waiting") then
        end
       end
      if matches[1]:lower() == "sticker" and is_momod(msg) or matches[1] == 'استیکر' and is_momod(msg) then
     redis:get("photo:sticker")  
    send_large_msg(receiver, '', ok_cb, false)
        load_photo(msg.reply_id, tosticker, msg)
    end
end
-------------------------
local receiver = get_receiver(msg)
    local group = msg.to.id
    if msg.reply_id then
       if msg.to.type == 'video' and redis:get("video:audio") then
        if redis:set("video:audio", "waiting") then
        end
       end
      if matches[1]:lower() == "audio" and is_momod(msg) or matches[1] == 'آهنگ' and is_momod(msg) then
     redis:get("video:audio")  
    send_large_msg(receiver, '', ok_cb, false)
        load_audio(msg.reply_id, toaudio, msg)
    end
end
-----------------------

local receiver = get_receiver(msg)
    local group = msg.to.id
    if msg.reply_id then
       if msg.to.type == 'document' and redis:get("gif:video") then
        if redis:set("gif:video", "waiting") then
        end
       end
      if matches[1]:lower() == "video" and is_momod(msg) or matches[1] == 'فیلم' and is_momod(msg) then
     redis:get("gif:video")  
    send_large_msg(receiver, '', ok_cb, false)
        load_document(msg.reply_id, tovideo, msg)
    end
end
------------------------
local receiver = get_receiver(msg)
    local group = msg.to.id
    if msg.reply_id then
       if msg.to.type == 'video' and redis:get("video:document") then
        if redis:set("video:document", "waiting") then
        end
       end
      if matches[1]:lower() == "mkv" and is_momod(msg) then
     redis:get("video:document")  
    send_large_msg(receiver, '', ok_cb, false)
        load_video(msg.reply_id, tomkv, msg)
    end
end
------------------------
  if matches[1] == "gif" and is_momod(msg) or matches[1] =="گیف" then 
local text = URL.escape(matches[2]) 
  local url2 = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script=blue-fire&text='..text..'&symbol_tagname=popular&fontsize=70&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=75&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=240&scaleHeight=120&&_=1469943010141' 
  local title , res = http.request(url2) 
  local jdat = json:decode(title) 
  local gif = jdat.src 
     local  file = download_to_file(gif,'t2g.gif') 
   send_document(get_receiver(msg), file, ok_cb, false) 
  end 
-----------------------
local receiver = get_receiver(msg) 
    local group = msg.to.id 
    if msg.reply_id then 
       if msg.to.type == 'video' and redis:get("video:gif") then 
        if redis:set("video:gif", "waiting") then 
        end 
       end 
      if matches[1]:lower() == "gif" and is_momod(msg) or matches[1] =="گیف" and is_momod(msg)  then 
     redis:get("video:gif") 
    send_large_msg(receiver, '', ok_cb, false) 
        load_video(msg.reply_id, togif, msg) 
    end 
end 
------------------------
if matches[1] == "get" then 
    local file = matches[2] 
    if is_sudo(msg) or is_vip(msg) then 
      local receiver = get_receiver(msg) 
      send_document(receiver, "./plugins/"..file..".lua", ok_cb, false) 
    end 
  end 
------------------------
local receiver = get_receiver(msg)
    local group = msg.to.id
    if msg.reply_id then
       if msg.to.type == 'photo' and redis:get("photo:sticker") then
        if redis:set("photo:png", "waiting") then
        end
       end
      if matches[1]:lower() == "png" and is_momod(msg) then
     redis:get("photo:png")  
    send_large_msg(receiver, '', ok_cb, false)
        load_photo(msg.reply_id, topng, msg)
    end
end
------------------------
if matches[1] == "delplugin" and is_sudo(msg) then
	      if not is_sudo(msg) then 
             return "You Are Not Allow To Delete Plugins!"
             end 
        io.popen("cd plugins && rm "..matches[2]..".lua")
        return "Delete plugin successful "
     end
end
end

return {               
patterns = {
   "^[#!/]([Aa]ddplugin) (.+) (.*)$",
    "^[#!/]([Dd]l) ([Pp]lugin) (.*)$",
   "^[!#/]([Cc]lean) (msg) (%d*)$",
   "^[!#/](rm)(sg) (%d*)$",
   "^[!#/](حذف) (پیام ها) (%d*)$",
   "^[!#/]([Dd]elplugin) (.*)$",
   "^[!/#](weather) (.*)$",
   "^[!/#](هواشناسی) (.*)$",
   "^[#!/](calc) (.*)$",
   "^[#!/](ماشین حساب) (.*)$",
   "^[#!/](time)$",
   "^[#!/](زمان)$",
   "^[!/#](voice) +(.*)$",
   "^[!/#](وویس) +(.*)$",
   "^[!/#]([Mm]ean) (.*)$",
   "^[!/#](معنی) (.*)$",
   "^[#!/](gif)$", 
   "^[#!/]([Ss]ticker)$",
   "^[#!/](photo)$",
"^[#!/](video)$",
"^[#!/](mkv)$",
"^[#!/](audio)$",
   "^[!/#](get) (.*)$", 
   "^[#!/](استیکر)$",
   "^[#!/](عکس)$",
   "^[#!/](گیف)$",
"^[#!/](فیلم)$",
"^[#!/](آهنگ)$",
   "^[#!/](gif) (.*)$", 
"^[#!/](png)$",
"^([Pp]hoto)$",
 "^([Ss]ticker)$",
   "%[(document)%]",
   "%[(photo)%]",
"%[(video)%]",
   "%[(audio)%]",
 }, 
run = run,
}

--edited by @blackwolf_admin 
--Create by @solid021
--edit by @mrr619
-- channel @antispamandhack