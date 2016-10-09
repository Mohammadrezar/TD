do
local function run(msg, matches, callback, extra)
local hash = 'group:'..msg.to.id
local group_lang = redis:hget(hash,'lang')
if matches[1] == 'نشاندن زبان' and  matches[2] == 'انگلیسی' and is_owner(msg) then 
    
   redis:hdel(hash,'lang')
        return 'group lang set to : en'
end



if matches[1] == 'نشاندن زبان' and matches[2] == 'فارسی' and is_owner(msg) then
redis:hset(hash,'lang',matches[2])
        return 'زبان گروه تنظیم شد به : FA'
end
if matches[1] == 'زبان' then
if group_lang then 
return "زبان گروه شما هم اکنون بر روی فارسی قرار دارد"
else
return "Group lang : en"
end
end
end
return {
  patterns = {
    "^[!#/](نشاندن زبان) (فارسی)$",
  "^[!#/](نشاندن زبان) (انگلیسی)$",
  "^[!#/](زبان)"
  },
  run = run
}
end
--edit by @CliApi
--Our channel : @create_antispam_bot