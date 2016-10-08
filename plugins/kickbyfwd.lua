local function run(msg, matches)
local hash = 'kmember:'..msg.to.id
    if matches[1] == 'kmember'or matches[1] =='حذف بافوروارد' and is_momod(msg) and redis:get(hash) == nil then
           redis:set(hash, "waite")
           return send_large_msg(get_receiver(msg), 'حالا پیام شخص مورد نظر را فوروارد کنید')
	elseif matches[1] == 'kmember'or matches[1] =='حذف بافوروارد' and is_momod(msg) and redis:get(hash) == "waite" then
	       return send_large_msg(get_receiver(msg),"شما قبلا در خواست کرده ایید لطفا پیام کاربر مورد نظر را فوروراد کنید دهید" )
 end
end

local function pre_process(msg)
local hash = 'kmember:'..msg.to.id
local service = msg.service
	if msg.fwd_from and is_momod(msg) then
	  if redis:get(hash) then
	     if redis:get(hash) == "waite" then
		 if is_momod2(msg.fwd_from.peer_id) then
		 return send_large_msg(get_receiver(msg), 'ایشان دارای مقام است')
		 end
	     redis:del(hash, true)
         kick_user(msg.fwd_from.peer_id, msg.to.id)
         return send_large_msg(get_receiver(msg), '❌کاربر '..msg.fwd_from.peer_id..' از گروه ('..msg.to.title..') اخراج شد')
        end
	  end
	end
	return msg
end

return {
	patterns = {
	"^[!#/](kmember)$",
	"^[!#/](حذف بافوروارد)$",
	},
	run = run,
	pre_process = pre_process,
}