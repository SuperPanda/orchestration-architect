# UNICODE CHARACTERS 

## CHOSEN 00AB and 00BB 

## GET UNICODE CHARACTERS FROM LUA IN VIM PROTOTYPES

## CURRENT Attempts

    00AB «
    00BB »
    300A《
    〈FILE〉
    300B 》  
    2329〈
    232A 〉
    〖unicode-print.lua 〗

```lua《lib/unicode_print.lua》
-- unicode_print.lua
local start = 0x0000
local end_code = 0x03FF  -- Extend to higher ranges (e.g., 0xFFFF) if needed

for i = start, end_code do
  local ok, char = pcall(utf8.char, i)  -- Gracefully handle invalid codepoints
  if ok then
    print(string.format("0x%04X: %s", i, char))
  else
    print(string.format("0x%04X: (INVALID)", i))
  end
end
```



## Previous Attempts 

## 0x00AA to 0x00BB

Visual Select then `:<',>'w !lua > /tmp/unicode.md`;
    
    for i = 0x00AA, 0x00BB do print(string.format("0x%04X: %s",i, string.char(i))) end

**OUTPUT**

Output with `:r /tmp/unicode.md`

    0x00AA: ª
    0x00AB: «
    0x00AC: ¬
    0x00AD: ­
    0x00AE: ®
    0x00AF: ¯
    0x00B0: °
    0x00B1: ±
    0x00B2: ²
    0x00B3: ³
    0x00B4: ´
    0x00B5: µ
    0x00B6: ¶
    0x00B7: ·
    0x00B8: ¸
    0x00B9: ¹
    0x00BA: º
    0x00BB: »
        

## 0x00A0 to 0x00FF

Visual Select then `:<',>'w !lua > /tmp/unicode.md`;
    
    for i = 0x00A0, 0x00FF do print(string.format("0x%04X: %s",i, string.char(i))) end

It does not work past 0x00FF, this is probably due to needing two characters for the unicode characters.

**OUTPUT**

Output with `:r /tmp/unicode.md`


    0x00A0:  
    0x00A1: ¡
    0x00A2: ¢
    0x00A3: £
    0x00A4: ¤
    0x00A5: ¥
    0x00A6: ¦
    0x00A7: §
    0x00A8: ¨
    0x00A9: ©
    0x00AA: ª
    0x00AB: «
    0x00AC: ¬
    0x00AD: ­
    0x00AE: ®
    0x00AF: ¯
    0x00B0: °
    0x00B1: ±
    0x00B2: ²
    0x00B3: ³
    0x00B4: ´
    0x00B5: µ
    0x00B6: ¶
    0x00B7: ·
    0x00B8: ¸
    0x00B9: ¹
    0x00BA: º
    0x00BB: »
    0x00BC: ¼
    0x00BD: ½
    0x00BE: ¾
    0x00BF: ¿
    0x00C0: À
    0x00C1: Á
    0x00C2: Â
    0x00C3: Ã
    0x00C4: Ä
    0x00C5: Å
    0x00C6: Æ
    0x00C7: Ç
    0x00C8: È
    0x00C9: É
    0x00CA: Ê
    0x00CB: Ë
    0x00CC: Ì
    0x00CD: Í
    0x00CE: Î
    0x00CF: Ï
    0x00D0: Ð
    0x00D1: Ñ
    0x00D2: Ò
    0x00D3: Ó
    0x00D4: Ô
    0x00D5: Õ
    0x00D6: Ö
    0x00D7: ×
    0x00D8: Ø
    0x00D9: Ù
    0x00DA: Ú
    0x00DB: Û
    0x00DC: Ü
    0x00DD: Ý
    0x00DE: Þ
    0x00DF: ß
    0x00E0: à
    0x00E1: á
    0x00E2: â
    0x00E3: ã
    0x00E4: ä
    0x00E5: å
    0x00E6: æ
    0x00E7: ç
    0x00E8: è
    0x00E9: é
    0x00EA: ê
    0x00EB: ë
    0x00EC: ì
    0x00ED: í
    0x00EE: î
    0x00EF: ï
    0x00F0: ð
    0x00F1: ñ
    0x00F2: ò
    0x00F3: ó
    0x00F4: ô
    0x00F5: õ
    0x00F6: ö
    0x00F7: ÷
    0x00F8: ø
    0x00F9: ù
    0x00FA: ú
    0x00FB: û
    0x00FC: ü
    0x00FD: ý
    0x00FE: þ
    0x00FF: ÿ
