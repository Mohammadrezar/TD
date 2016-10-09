do
local function pre_process(msg)
    local hash = 'muter:'..msg.to.id
    if redis:get(hash) and msg.reply_id and not is_sudo(msg) and not is_owner(msg) and not is_momod(msg) and not is_admin1(msg) then
            delete_msg(msg.id, ok_cb, true)
            return "done"
        end
        return msg
    end
    
local function run(msg, matches)
    chat_id =  msg.to.id
    if is_momod(msg) and matches[1] == 'lock' or matches[1] == 'قفل کردن' then
                    local hash = 'muter:'..msg.to.id
                    redis:set(hash, true)
                    return "》ریپلی در گروه قفل شد."
  elseif is_momod(msg) and matches[1] == 'unlock' or matches[1] == 'بازکردن'
then
                    local hash = 'muter:'..msg.to.id
                    redis:del(hash)
                    return "》ریپلی در گروه آزاد شد."
end
end
return {
    patterns = {
        '^[/!#](lock) reply$',
        '^[/!#](unlock) reply$',
        '^[/!#](قفل کردن) ریپلی$',
        '^[/!#](بازکردن) ریپلی$'
    },
    run = run,
    pre_process = pre_process
}
end
