--[[

        @cruel نویسنده
		@cruel_channel
		@gpmod



]]--





do
local function view_sura(chat_id, target)
	local f = io.open("./plugins/("..target..").lua","r")
	if f ~= nil then
		local text = f:read("*all")
		return text
	else
		return 'پلاگین یافت نشد'
	end
end

local function run(msg, matches)
    local chat_id = msg.to.id
	if matches [1] == "how" and is_sudo(msg) then
		local file = io.open("./plugins/"..matches [2]..".lua", "r")
		local text = file:read("*all")
		return text
	end
end

return {
	patterns = {
		"^[Ss](how) (.+)$",
    }, 
	run = run,
	}
end


--[[

        @cruel نویسنده
		@cruel_channel
		@gpmod



]]--


