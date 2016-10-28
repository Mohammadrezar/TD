function run(msg, matches)
if not is_sudo(msg) then
return 
end
text = io.popen("uptime"):read('*all')
  return text
end
return {
  patterns = {
    "^[!/](uptime)$"
  },
  run = run,
  moderated = true
}