local function to_kana(romaji, dict)
    local result = ""
    local i = 1
    while i <= #romaji do
        local found = false
        for len = 3, 1, -1 do
            local part = romaji:sub(i, i + len - 1)
            if dict[part] then
                result = result .. dict[part]
                i = i + len
                found = true
                break
            end
        end
        if not found then
            result = result .. romaji:sub(i, i)
            i = i + 1
        end
    end
    return result
end

--[[
1:小 2:z  3:m  4:記 5:f  6:v  7:un 8:in 9:on 0:en
 Q:b  W:r  E:ん R:n  T:t  Y:ai U:uu I:ai O:ou P:ei
  A:w  S:h  D:s  F:k  G:g  H:a  J:i  K:u  L:e  ;:o
   Z:y  X:p  C:D  V:っ B:   N:拗 M:   ,:、 .:。
]]
--

local consonants = {
    f = "k",
    g = "g",
    d = "s",
    ["2"] = "z",
    t = "t",
    c = "d",
    r = "n",
    s = "h",
    ["5"] = "hux",
    ["6"] = "vux",
    q = "b",
    x = "p",
    ["3"] = "m",
    z = "y",
    w = "r",
    a = "w",
    ["1"] = "x",
}
local vowels = {
    h = "a",
    j = "i",
    k = "u",
    l = "e",
    [";"] = "o",
    y = "ann",
    ["8"] = "inn",
    ["7"] = "unn",
    ["0"] = "enn",
    ["9"] = "onn",
    u = "uu",
    i = "ai",
    o = "ou",
    p = "ei",
}
local romaji_map_no_youon = {
    a = "あ",
    i = "い",
    u = "う",
    e = "え",
    o = "お",
    xa = "ぁ",
    xi = "ぃ",
    xu = "ぅ",
    xe = "ぇ",
    xo = "ぉ",
    ka = "か",
    ki = "き",
    ku = "く",
    ke = "け",
    ko = "こ",
    ga = "が",
    gi = "ぎ",
    gu = "ぐ",
    ge = "げ",
    go = "ご",
    sa = "さ",
    si = "し",
    su = "す",
    se = "せ",
    so = "そ",
    za = "ざ",
    zi = "じ",
    zu = "ず",
    ze = "ぜ",
    zo = "ぞ",
    ta = "た",
    ti = "ち",
    tu = "つ",
    xtu = "っ",
    te = "て",
    to = "と",
    da = "だ",
    di = "ぢ",
    du = "づ",
    de = "で",
    ["do"] = "ど",
    na = "な",
    ni = "に",
    nu = "ぬ",
    ne = "ね",
    no = "の",
    ha = "は",
    hi = "ひ",
    hu = "ふ",
    he = "へ",
    ho = "ほ",
    ba = "ば",
    bi = "び",
    bu = "ぶ",
    be = "べ",
    bo = "ぼ",
    pa = "ぱ",
    pi = "ぴ",
    pu = "ぷ",
    pe = "ぺ",
    po = "ぽ",
    vu = "ゔ",
    ma = "ま",
    mi = "み",
    mu = "む",
    me = "め",
    mo = "も",
    ya = "や",
    yu = "ゆ",
    yo = "よ",
    xya = "ゃ",
    xyu = "ゅ",
    xyo = "ょ",
    ra = "ら",
    ri = "り",
    ru = "る",
    re = "れ",
    ro = "ろ",
    wa = "わ",
    wo = "を",
    nn = "ん",
}
local youon_romaji_map = {}
for k, v in pairs(romaji_map_no_youon) do
    if #k == 2 and k:sub(2, 2) == "i" then
        youon_romaji_map[k:sub(1, 1) .. "ya"] = v .. "ゃ"
        youon_romaji_map[k:sub(1, 1) .. "yu"] = v .. "ゅ"
        youon_romaji_map[k:sub(1, 1) .. "yo"] = v .. "ょ"
    end
end
local romaji_map = vim.tbl_extend("force", romaji_map_no_youon, youon_romaji_map)

local kanatable_romaji = {}

for ck, cv in pairs(consonants) do
    for vk, vv in pairs(vowels) do
        kanatable_romaji[ck .. vk] = cv .. vv
        kanatable_romaji[ck .. "n" .. vk] = cv .. "y" .. vv
        kanatable_romaji[ck .. ":" .. vk] = cv .. "y" .. vv
    end
end
local final_kanatable = {}

for key, romaji in pairs(kanatable_romaji) do
    local kana = to_kana(romaji, romaji_map)
    if kana then
        final_kanatable[key] = { kana, "" }
    end
end

local specials = {
    [" "] = "henkanFirst",
    ["^"] = "henkanPoint",
    ["<s-b>"] = "zenkaku",
    ["@"] = "katakana",
    ["/"] = "abbrev",

    ["["] = { "「", "" },
    ["]"] = { "」", "" },
    ["-"] = { "ー", "" },
    ["4,"] = { "‥", "" },
    ["4."] = { "…", "" },
    ["4/"] = { "・", "" },
    ["4["] = { "『", "" },
    ["4]"] = { "』", "" },
    ["4h"] = { "←", "" },
    ["4j"] = { "↓", "" },
    ["4k"] = { "↑", "" },
    ["4l"] = { "→", "" },

    ["h"] = { "あ", "" },
    ["j"] = { "い", "" },
    ["k"] = { "う", "" },
    ["l"] = { "え", "" },
    [";"] = { "お", "" },
    ["e"] = { "ん", "" },
    ["v"] = { "っ", "" },
    [","] = { "、", "" },
    ["."] = { "。", "" },
}
local kanatable = vim.tbl_extend("force", final_kanatable, specials)

return kanatable
