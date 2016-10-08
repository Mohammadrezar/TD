local function run(msg, matches)
    if is_momod(msg) then
        return
    end
    local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
        if data[tostring(msg.to.id)]['settings'] then
            if data[tostring(msg.to.id)]['settings']['operator'] then
                lock_operator = data[tostring(msg.to.id)]['settings']['operator']
            end
        end
    end
    local chat = get_receiver(msg)
    local user = "user#id"..msg.from.id
    if lock_operator == "yes" then
       delete_msg(msg.id, ok_cb, true)
    end
end
 
return {
  patterns = {
  "شارژ",
  "ایرانسل",
  "irancell",
  "ir-mci",
  "همراه اول",
  "رایتل",
  "تالیا",
  },
  run = run
}
