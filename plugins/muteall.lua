-- by @Blackwolf_admin 
--edit by @Mrr619
-- channel : @antispamandhack
do
local function pre_process(msg)
 local hash = 'muteall:'..msg.to.id
  if redis:get(hash) and msg.to.type == 'channel' and not is_momod(msg)  then
   delete_msg(msg.id, ok_cb, false)
       end
    return msg
 end
 
local function run(msg, matches)
 if matches[1] == 'muteall'or matches[1] =='ساکت کردن همه' and is_momod(msg) then
       local hash = 'muteall:'..msg.to.id
       if not matches[2] then
              redis:set(hash, true)
             return "mute all has been enabled"
 else
-- by @Blackwolf_admin 
local hour = string.gsub(matches[2], 'h', '')
 local num1 = tonumber(hour) * 3600
local minutes = string.gsub(matches[3], 'm', '')
 local num2 = tonumber(minutes) * 60
local second = string.gsub(matches[4], 's', '')
 local num3 = tonumber(second) 
local num4 = tonumber(num1 + num2 + num3)
redis:setex(hash, num4, true)
 return "mute all has been enabled for\n⏺ hour(s) : "..matches[2].."\n⏺ minute(s) : "..matches[3].." \n⏺ second(s) : "..matches[4]..""
 end
 end
if matches[1] == 'unmuteall'or matches[1] =='مصوت کردن همه' and is_momod(msg) then
               local hash = 'muteall:'..msg.to.id
        redis:del(hash)
          return "mute all has been disabled"
  end
end
return {
   patterns = {
      '^[/!#](muteall)$',
      '^[/!#](unmuteall)$',
   '^[/!#](muteall) (.*) (.*) (.*)$',
      '^[/!#](ساکت کردن همه)$',
      '^[/!#](مصوت کردن همه)$',
   '^[/!#](ساکت کردن همه) (.*) (.*) (.*)$',
 },
run = run,
  pre_process = pre_process
}
end
-- by @Blackwolf_admin 
-- edit by @Mrr619
-- our channel : @antispamandhack 