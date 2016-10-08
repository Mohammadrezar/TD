--by [@alireza_PT]
--Our channel [@create_antispam_bot]

local function run(msg, matches)
        local text = URL.escape(matches[1])
         local bgcolor = 'mathrm'
        if matches[2] == 'blue' then
            bgcolor = '0000ff'
        elseif matches[2] == 'pink' then
            bgcolor = 'e11bca'
             elseif matches[2] == 'violet' then
            bgcolor = '7366BD'
             elseif matches[2] == 'red' then
            bgcolor = 'ff0000'
             elseif matches[2] == 'brown' then
            bgcolor = 'B4674D'
             elseif matches[2] == 'orange' then
            bgcolor = 'FF7F49'
             elseif matches[2] == 'gray' then
            bgcolor = 'B0B7C6'
        elseif matches[2] == 'cream' then
            bgcolor = 'FFFF99'
        elseif matches[2] == 'green' then
            bgcolor = '00ff00'
             elseif matches[2] == 'black' then
            bgcolor = '000000'
            elseif matches[2] == 'white' then
            bgcolor = 'ffffff'
            elseif matches[2] == 'Fuchsia' then
            bgcolor = 'ff00ff'
            elseif matches[2] == 'Aqua' then
            bgcolor = '00ffff'
            elseif matches[2] == 'yellow' then
            bgcolor = 'ffff00'
        end
        local textcolor = 'blue'
        if matches[3] == 'blue' then
            textcolor = '0000ff'
        elseif matches[3] == 'pink' then
            textcolor = 'e11bca'
             elseif matches[3] == 'violet' then
            textcolor = '7366BD'
             elseif matches[3] == 'red' then
            textcolor = 'ff0000'
             elseif matches[3] == 'brown' then
            textcolor = 'B4674D'
             elseif matches[3] == 'orange' then
            textcolor = 'FF7F49'
             elseif matches[3] == 'gray' then
            textcolor = 'B0B7C6'
        elseif matches[3] == 'cream' then
            textcolor = 'FFFF99'
        elseif matches[3] == 'green' then
            textcolor = '00ff00'
             elseif matches[3] == 'black' then
            textcolor = '000000'
            elseif matches[3] == 'white' then
            textcolor = 'ffffff'
            elseif matches[3] == 'Fuchsia' then
            textcolor = 'ff00ff'
            elseif matches[3] == 'Aqua' then
            textcolor = '00ffff'
            elseif matches[3] == 'yellow' then
            textcolor = 'ffff00'
        end
        local text = '700'
        if matches[4] == 'blue' then
            text = '0000ff'
        elseif matches[4] == 'pink' then
            text = 'e11bca'
             elseif matches[4] == 'violet' then
            text = '7366BD'
             elseif matches[4] == 'red' then
            text = 'ff0000'
             elseif matches[4] == 'brown' then
            text = 'B4674D'
             elseif matches[4] == 'orange' then
            text = 'FF7F49'
             elseif matches[4] == 'gray' then
            text = 'B0B7C6'
        elseif matches[4] == 'cream' then
            text = 'FFFF99'
        elseif matches[4] == 'green' then
            text = '00ff00'
             elseif matches[4] == 'black' then
            text = '000000'
            elseif matches[4] == 'white' then
            text = 'ffffff'
            elseif matches[4] == 'Fuchsia' then
            text = 'ff00ff'
            elseif matches[4] == 'Aqua' then
            text = '00ffff'
            elseif matches[4] == 'yellow' then
            text = 'ffff00'
        end
         local size = 'size'
        if matches[5] == '100' then
            size = '100'
        elseif matches[5] == '200' then
            size = '200'
             elseif matches[5] == '300' then
            size = '300'
             elseif matches[5] == '400' then
            size = '400'
             elseif matches[5] == '500' then
            size = '500'
             elseif matches[5] == '600' then
            size = '600'
             elseif matches[5] == '700' then
            size = '700'
        elseif matches[5] == '800' then
            size = '800'
        elseif matches[5] == '900' then
            size = '900'
             elseif matches[5] == '1000' then
            size = '1000'
        end
local url = "http://www.keepcalmstudio.com/-/p.php?t=%EE%BB%AA%0D%0AKEEP%0D%0ACALM%0D%0AAND%0D%0A"..URL.escape(matches[1]).."&bc="..bgcolor.."&tc="..textcolor.."&cc="..text.."&w="..size.."&uc=true&ts=true&ff=PNG&ps=sq"
local file = download_to_file(url,'file.webp')
if msg.to.type == 'channel' then
send_document('channel#id'..msg.to.id,file,ok_cb,false)
else
send_document('chat#id'..msg.to.id,file,ok_cb,false)
end
end
return {
   patterns = {
	    "^[/!#]keepcalm (.*) (.*) (.*) (.*) (.*)$",
       },
   run = run
}
--by [@alireza_PT]
--Our channel [@create_antispam_bot]