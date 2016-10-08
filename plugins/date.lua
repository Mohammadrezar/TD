function run(msg, matches)
local url , res = http.request('http://api.gpmod.ir/time/')
if res ~= 200 then return "No connection" end
local jdat = json:decode(url)
local text = '馃晵 爻丕毓鬲 '..jdat.FAtime..' \n馃搯 丕賲乇賵夭 '..jdat.FAdate..' 賲蹖亘丕卮丿.\n    ----\n馃晵 '..jdat.ENtime..'\n馃搯 '..jdat.ENdate.. '\n@antispamandhack'
return text
end
return {
  patterns = {"^[#!/]([Tt]ime&date)$","^تاریخ$",
}, 
run = run 
}
