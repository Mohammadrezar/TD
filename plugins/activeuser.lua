local function checktodaygr(cb_extra, success, result)
	local hash = ''
	local thash=''
	for k,user in pairs(result.members) do
	thash = 'today:'..user.peer_id
	if redis:get(thash) then
	if redis:get(thash) < os.date("%x",os.time() + 16200) then
    hash = 'utmsgst:'..user.peer_id..':'..cb_extra
    redis:set(hash,0)
    hash = 'utmsgph:'..user.peer_id..':'..cb_extra
   redis:set(hash,0)
    hash = 'utmsgtex:'..user.peer_id..':'..cb_extra
    redis:set(hash,0)
    hash = 'utmsgoth:'..user.peer_id..':'..cb_extra
    redis:set(hash,0)
	redis:set(thash,os.date("%x",os.time() + 16200))
	end
	else
	redis:set(thash,os.date("%x",os.time() + 16200))
	end
	end
end
local function checktodaych(cb_extra, success, result)
	local hash = ''
	local thash=''
	for k,user in pairs(result) do
	thash = 'today:'..user.peer_id
	if redis:get(thash) then
	if redis:get(thash) < os.date("%x",os.time() + 16200) then
    hash = 'utmsgst:'..user.peer_id..':'..cb_extra
    redis:set(hash,0)
    hash = 'utmsgph:'..user.peer_id..':'..cb_extra
   redis:set(hash,0)
    hash = 'utmsgtex:'..user.peer_id..':'..cb_extra
    redis:set(hash,0)
    hash = 'utmsgoth:'..user.peer_id..':'..cb_extra
    redis:set(hash,0)
	redis:set(thash,os.date("%x",os.time() + 16200))
	end
	else
	redis:set(thash,os.date("%x",os.time() + 16200))
	end
	end
end
local function cron()
for v,chat in pairs(_chats.chats) do
channel_get_users('channel#id'..chat[1], checktodaych, chat[1])
chat_info('chat#id'..chat[1], checktodaygr, chat[1])
    end
end
local function pre_process(msg)
if not msg.service then
    if msg.media then
    if msg.media.caption == 'sticker.webp' then
    local hash = 'utmsgst:'..msg.from.id..':'..msg.to.id
    redis:incr(hash)
    elseif msg.media.type == 'photo' then
    local hash = 'utmsgph:'..msg.from.id..':'..msg.to.id
    redis:incr(hash)
    end
    else
    if msg.text then
    local hash = 'utmsgtex:'..msg.from.id..':'..msg.to.id
    redis:incr(hash)
    else
    local hash = 'utmsgoth:'..msg.from.id..':'..msg.to.id
    redis:incr(hash)
    end
	end
end
return msg
end
local function getactivegr(cb_extra, success, result)
    local maxst = {}
    local maxph = {}
    local maxtex = {}
    local maxoth = {}
    local maxname = {}
    local maxuser = {}
    local maxid = {}
    local maxstat = {}
    maxstat[1] = 0
    maxstat[2] = 0
    maxstat[3] = 0
    maxname[1] = ''
    maxname[2] = ''
    maxname[3] = ''
    maxuser[1] = ''
    maxuser[2] = ''
    maxuser[3] = ''
	for k,user in pairs(result.members) do
    local shash = 'utmsgst:'..user.peer_id..':'..cb_extra
    local phash = 'utmsgph:'..user.peer_id..':'..cb_extra
    local thash = 'utmsgtex:'..user.peer_id..':'..cb_extra
    local ohash = 'utmsgoth:'..user.peer_id..':'..cb_extra
    if not redis:get(shash) then
    redis:set(shash,0)
   end
       if not redis:get(phash) then
    redis:set(phash,0)
   end
       if not redis:get(thash) then
    redis:set(thash,0)
   end
       if not redis:get(ohash) then
    redis:set(ohash,0)
   end
   if  tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash)) + tonumber(redis:get(ohash)) > maxstat[1] then
	maxname[3] = maxname[2]
	maxuser[3] = maxuser[2]
	maxstat[3] = maxstat[2]
	maxid[3] = maxid[2]
	maxname[2] = maxname[1]
	maxuser[2] = maxuser[1]
	maxstat[2] = maxstat[1]
	maxid[2] = maxid[1]
maxname[1] = user.print_name
	maxuser[1] = user.username
	maxid[1] = user.peer_id
	maxstat[1] = tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash)) + tonumber(redis:get(ohash))
	elseif tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash)) + tonumber(redis:get(ohash)) > maxstat[2] then
	maxname[3] = maxname[2]
	maxuser[3] = maxuser[2]
	maxstat[3] = maxstat[2]
	maxid[3] = maxid[2]
maxname[2] = user.print_name
	maxuser[2] = user.username
	maxid[2] = user.peer_id
	maxstat[2] = tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash)) + tonumber(redis:get(ohash))
	elseif tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash)) + tonumber(redis:get(ohash)) > maxstat[3] then
	maxname[3] = user.print_name
	maxuser[3] = user.username
	maxid[3] = user.peer_id
	maxstat[3] = tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash)) + tonumber(redis:get(ohash))
	end
	end
	maxst[1] = redis:get('utmsgst:'..maxid[1]..':'..cb_extra)
	maxph[1] = redis:get('utmsgph:'..maxid[1]..':'..cb_extra)
	maxtex[1] = redis:get('utmsgtex:'..maxid[1]..':'..cb_extra)
	maxoth[1] = redis:get('utmsgoth:'..maxid[1]..':'..cb_extra)
	if maxid[2] then
	maxst[2] = redis:get('utmsgst:'..maxid[2]..':'..cb_extra)
	maxph[2] = redis:get('utmsgph:'..maxid[2]..':'..cb_extra)
	maxtex[2] = redis:get('utmsgtex:'..maxid[2]..':'..cb_extra)
	maxoth[2] = redis:get('utmsgoth:'..maxid[2]..':'..cb_extra)
	end
	if maxid[3] then
	maxst[3] = redis:get('utmsgst:'..maxid[3]..':'..cb_extra)
	maxph[3] = redis:get('utmsgph:'..maxid[3]..':'..cb_extra)
	maxtex[3] = redis:get('utmsgtex:'..maxid[3]..':'..cb_extra)
	maxoth[3] = redis:get('utmsgoth:'..maxid[3]..':'..cb_extra)
	end
	if not maxuser[1] or maxuser[1] == '' then
	maxuser[1] = 'ندارد'
	else
	maxuser[1] = '@'..maxuser[1]
	end
	if not maxuser[2] or maxuser[2] == '' then
	maxuser[2] = 'ندارد'
	else
	maxuser[2] = '@'..maxuser[2]
	end
	if not maxuser[3] or maxuser[3] == '' then
	maxuser[3] = 'ندارد'
	else
	maxuser[3] = '@'..maxuser[3]
end
local text = '♨️فعالان امروز گروه\n1⃣ '..maxname[1]..'〖'..maxuser[1]..'〗\n\n📨تعداد پیام های ارسالی: '..maxtex[1] + maxph[1] + maxst[1] + maxoth[1]..'\n\n👾استیکر: '..maxst[1]..'\n\n📷تصویر: '..maxph[1]..'\n\n📃 متن: '..maxtex[1]..'\n\n📦 سایر: '..maxoth[1]
if maxid[2] then
	if not maxid[3] then
text = text..'\n\n 2⃣ '..maxname[2]..' 〖'..maxuser[2]..'〗\n\n📨تعداد پیام های ارسالی: '..maxtex[2] + maxph[2] + maxst[2] + maxoth[2]..'\n\n👾استیکر: '..maxst[2]..'\n\n📷تصویر: '..maxph[2]..'\n\n📃 متن: '..maxtex[2]..'\n\n📦 سایر: '..maxoth[2]
else
text = text..'\n\n 2⃣ '..maxname[2]..' 〖'..maxuser[2]..'〗\n\n📨تعداد پیام های ارسالی: '..maxtex[2] + maxph[2] + maxst[2] + maxoth[2]..'\n\n👾استیکر: '..maxst[2]..'\n\n📷تصویر: '..maxph[2]..'\n\n📃 متن: '..maxtex[2]..'\n\n📦 سایر: '..maxoth[2]..'\n\n 3⃣ '..maxname[3]..' 〖'..maxuser[3]..'〗\n\n📨تعداد پیام های ارسالی: '..maxtex[3] + maxph[3] + maxst[3] + maxoth[3]..'\n\n👾استیکر: '..maxst[3]..'\n\n📷تصویر: '..maxph[3]..'\n\n📃 متن: '..maxtex[3]..'\n\n📦 سایر: '..maxoth[3]
end
end
send_msg('chat#id'..cb_extra, text, ok_cb, true)
end
local function getactivech(cb_extra, success, result)
    local maxst = {}
    local maxph = {}
    local maxtex = {}
    local maxoth = {}
    local maxname = {}
    local maxuser = {}
    local maxid = {}
    local maxstat = {}
    maxstat[1] = 0
    maxstat[2] = 0
    maxstat[3] = 0
    maxname[1] = ''
    maxname[2] = ''
    maxname[3] = ''
    maxuser[1] = ''
    maxuser[2] = ''
    maxuser[3] = ''
	for k,user in pairs(result) do
    local shash = 'utmsgst:'..user.peer_id..':'..cb_extra
    local phash = 'utmsgph:'..user.peer_id..':'..cb_extra
    local thash = 'utmsgtex:'..user.peer_id..':'..cb_extra
    local ohash = 'utmsgoth:'..user.peer_id..':'..cb_extra
    if not redis:get(shash) then
    redis:set(shash,0)
   end
       if not redis:get(phash) then
    redis:set(phash,0)
   end
       if not redis:get(thash) then
    redis:set(thash,0)
   end
       if not redis:get(ohash) then
    redis:set(ohash,0)
   end
   if  tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash)) + tonumber(redis:get(ohash)) > maxstat[1] then
	maxname[3] = maxname[2]
	maxuser[3] = maxuser[2]
	maxstat[3] = maxstat[2]
	maxid[3] = maxid[2]
	maxname[2] = maxname[1]
	maxuser[2] = maxuser[1]
	maxstat[2] = maxstat[1]
	maxid[2] = maxid[1]
maxname[1] = user.print_name
	maxuser[1] = user.username
	maxid[1] = user.peer_id
	maxstat[1] = tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash)) + tonumber(redis:get(ohash))
	elseif tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash)) + tonumber(redis:get(ohash)) > maxstat[2] then
	maxname[3] = maxname[2]
	maxuser[3] = maxuser[2]
	maxstat[3] = maxstat[2]
	maxid[3] = maxid[2]
maxname[2] = user.print_name
	maxuser[2] = user.username
	maxid[2] = user.peer_id
	maxstat[2] = tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash)) + tonumber(redis:get(ohash))
	elseif tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash)) + tonumber(redis:get(ohash)) > maxstat[3] then
	maxname[3] = user.print_name
	maxuser[3] = user.username
	maxid[3] = user.peer_id
	maxstat[3] = tonumber(redis:get(shash)) + tonumber(redis:get(phash)) + tonumber(redis:get(thash)) + tonumber(redis:get(ohash))
	end
	end
	maxst[1] = redis:get('utmsgst:'..maxid[1]..':'..cb_extra)
	maxph[1] = redis:get('utmsgph:'..maxid[1]..':'..cb_extra)
	maxtex[1] = redis:get('utmsgtex:'..maxid[1]..':'..cb_extra)
	maxoth[1] = redis:get('utmsgoth:'..maxid[1]..':'..cb_extra)
	if maxid[2] then
	maxst[2] = redis:get('utmsgst:'..maxid[2]..':'..cb_extra)
	maxph[2] = redis:get('utmsgph:'..maxid[2]..':'..cb_extra)
	maxtex[2] = redis:get('utmsgtex:'..maxid[2]..':'..cb_extra)
	maxoth[2] = redis:get('utmsgoth:'..maxid[2]..':'..cb_extra)
	end
	if maxid[3] then
	maxst[3] = redis:get('utmsgst:'..maxid[3]..':'..cb_extra)
	maxph[3] = redis:get('utmsgph:'..maxid[3]..':'..cb_extra)
	maxtex[3] = redis:get('utmsgtex:'..maxid[3]..':'..cb_extra)
	maxoth[3] = redis:get('utmsgoth:'..maxid[3]..':'..cb_extra)
	end
	if not maxuser[1] or maxuser[1] == '' then
	maxuser[1] = 'ندارد'
	else
	maxuser[1] = '@'..maxuser[1]
	end
	if not maxuser[2] or maxuser[2] == '' then
	maxuser[2] = 'ندارد'
	else
	maxuser[2] = '@'..maxuser[2]
	end
	if not maxuser[3] or maxuser[3] == '' then
	maxuser[3] = 'ندارد'
	else
	maxuser[3] = '@'..maxuser[3]
end
local text = '♨️فعالان امروز گروه\n1⃣ '..maxname[1]..'〖'..maxuser[1]..'〗\n\n📨تعداد پیام های ارسالی: '..maxtex[1] + maxph[1] + maxst[1] + maxoth[1]..'\n\n👾استیکر: '..maxst[1]..'\n\n📷تصویر: '..maxph[1]..'\n\n📃 متن: '..maxtex[1]..'\n\n📦 سایر: '..maxoth[1]
if maxid[2] then
	if not maxid[3] then
text = text..'\n\n 2⃣ '..maxname[2]..' 〖'..maxuser[2]..'〗\n\n📨تعداد پیام های ارسالی: '..maxtex[2] + maxph[2] + maxst[2] + maxoth[2]..'\n\n👾استیکر: '..maxst[2]..'\n\n📷تصویر: '..maxph[2]..'\n\n📃 متن: '..maxtex[2]..'\n\n📦 سایر: '..maxoth[2]
else
text = text..'\n\n 2⃣ '..maxname[2]..' 〖'..maxuser[2]..'〗\n\n📨تعداد پیام های ارسالی: '..maxtex[2] + maxph[2] + maxst[2] + maxoth[2]..'\n\n👾استیکر: '..maxst[2]..'\n\n📷تصویر: '..maxph[2]..'\n\n📃 متن: '..maxtex[2]..'\n\n📦 سایر: '..maxoth[2]..'\n\n 3⃣ '..maxname[3]..' 〖'..maxuser[3]..'〗\n\n📨تعداد پیام های ارسالی: '..maxtex[3] + maxph[3] + maxst[3] + maxoth[3]..'\n\n👾استیکر: '..maxst[3]..'\n\n📷تصویر: '..maxph[3]..'\n\n📃 متن: '..maxtex[3]..'\n\n📦 سایر: '..maxoth[3]
end
end
send_msg('channel#id'..cb_extra, text, ok_cb, true)
end
local function run(msg,matches)
if msg.to.type == 'channel' then
channel_get_users('channel#id'..msg.to.id, getactivech, msg.to.id)
elseif msg.to.type == 'chat' then
chat_info('chat#id'..msg.to.id, getactivegr, msg.to.id)
end
end
return {
  patterns = {
    "^[!/#]msguser$",
    "^[!/#]topuser$",
    "^[!#/]فعالان گروه$",
  }, 
  pre_process = pre_process,
  cron = cron,
  run = run
}