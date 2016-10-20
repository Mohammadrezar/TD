local function history(extra, suc, result)
  for i=1, #result do
    delete_msg(result[i].id, ok_cb, false)
  end
  if tonumber(extra.con) == #result then
    send_msg(extra.chatid, '"'..#result..'" پیام اخیر سوپر گروه حذف شد', ok_cb, false)
  else
    send_msg(extra.chatid, 'تعداد پیام مورد نظر شما پاک شد', ok_cb, false)
  end
end
local function run(msg, matches)
  if matches[1] == 'clean' and is_owner(msg) or matches[1] =='حذف' and is_owner(msg) or matches[1] == 'rm' and is_owner(msg) then
    if msg.to.type == 'channel' then
      if tonumber(matches[2]) > 200 or tonumber(matches[2]) < 1 then
        return "☆تعداد بیشتر از حد مجاز است\n》لطفا عددی بین 1-100 انتخاب کنید."
      end
      get_history(msg.to.peer_id, matches[2] + 1 , history , {chatid = msg.to.peer_id, con = matches[2]})
    else
      return "فقط در سوپرگروه ممکن است"
    end
  else
    return "دس نزن بچه"
  end
end

return {
    patterns = {
        '^[!/#](clean) msg (%d*)$',
        '^[!/#](rm)sg (%d*)$',
        '^[!/#](حذف) پیام ها (%d*)$'
    },
    run = run
}
