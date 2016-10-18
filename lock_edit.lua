do

function promote(receiver, member_username, user_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'channel#id', '')
  local member_tag_username = string.gsub(member_username, '@', '(at)')
  if not data[group] then
    return 
  end
  if data[group]['moderators'][tostring(user_id)] then
    return 
  end
  data[group]['moderators'][tostring(user_id)] = member_tag_username
  save_data(_config.moderation.data, data)
end

function lock_edit(msg)
  if not is_momod(msg) then
    return
  end
  if redis:get("lock:edit:"..msg.to.id) then
    return '》Edit is already locked\n》ویرایش پیام هم اکنون ممنوع است.'
  else
    promote(msg.to.id,"@edit_locker_bot",240486291)
    channel_invite(get_receiver(msg),"user#id240486291",ok_cb,false)
    redis:set("lock:edit:"..msg.to.id,true)
    return '》Edit locked\n》ویرایش پیام ممنوع شد.'
  end
end

function unlock_edit(msg)
  if not is_momod(msg) then
    return
  end
  if not redis:get("lock:edit:"..msg.to.id) then
    return '》Edit is not locked\n》ویرایش پیام مجاز بود .'
  else
    redis:del("lock:edit:"..msg.to.id)
    return '》Edit unlocked\n》ویرایش پیام مجاز شد.'
  end
end

function pre_process(msg)
  if msg.from.id == 240486291 then
    if redis:get("lock:edit:"..msg.to.id) then
    if is_momod2(tonumber(msg.text),msg.to.id) then
        delete_msg(msg.id,ok_cb,false)
    else
      delete_msg(msg.id,ok_cb,false)
    delete_msg(msg.reply_id,ok_cb,false)
    end
  else
      delete_msg(msg.id,ok_cb,false)
  end
  end
  return msg
end

function run(msg,matches)
  if matches[2] == "edit" and is_momod(msg) then
  if matches[1] == "lock" then
    if msg.to.type == "channel" then
    return lock_edit(msg)
    else
      return "Only in SuperGroups"
    end
  elseif matches[1] == "unlock" then
    if msg.to.type == "channel" then
    return unlock_edit(msg)
    else
      return "Only in SuperGroups"
    end
    end
  end
end

return {
  patterns = {
    "^[!/#](lock) (edit)$",
  "^[!/#](unlock) (edit)$"
  },
  run = run,
  pre_process = pre_process
}

end