local function merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
    return t1
end

local function to_kana(romaji, dict)
    local results = {}
    local i = 1
    while i <= #romaji do
        local found = false
        for len = 3, 1, -1 do
            local part = romaji:sub(i, i + len - 1)
            if dict[part] then
                table.insert(results, dict[part])
                i = i + len
                found = true
                break
            end
        end
        if not found then
            table.insert(results, romaji:sub(i, i))
            i = i + 1
        end
    end
    return table.concat(results)
end

local consonants = {
    l = "x",
    k = "k",
    g = "g",
    s = "s",
    z = "z",
    t = "t",
    d = "d",
    n = "n",
    h = "h",
    f = "f",
    b = "b",
    v = "v",
    p = "p",
    m = "m",
    y = "y",
    r = "r",
    w = "w",
}
local vowels = {
    a = "a",
    i = "i",
    u = "u",
    e = "e",
    o = "o",
    c = "ann",
    h = "inn",
    d = "unn",
    z = "enn",
    k = "onn",
    r = "ei",
    t = "ai",
    s = "uu",
    n = "ou",
}
local romaji_map = {
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
    fa = "ふぁ",
    fi = "ふぃ",
    fu = "ふ",
    fe = "ふぇ",
    fo = "ふぉ",
    va = "ゔぁ",
    vi = "ゔぃ",
    vu = "ゔ",
    ve = "ゔぇ",
    vo = "ゔぉ",
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
    wi = "うぃ",
    we = "うぇ",
    wo = "を",
    nn = "ん",
}
local youon_map = {}
for k, v in pairs(romaji_map) do
    if #k == 2 and k:sub(2, 2) == "i" then
        youon_map[k:sub(1, 1) .. "ya"] = v .. "ゃ"
        youon_map[k:sub(1, 1) .. "yu"] = v .. "ゅ"
        youon_map[k:sub(1, 1) .. "ye"] = v .. "ぇ"
        youon_map[k:sub(1, 1) .. "yo"] = v .. "ょ"
    elseif #k == 2 and k:sub(2, 2) == "e" then
        youon_map[k:sub(1, 1) .. "yi"] = v .. "ぃ"
    end
end
romaji_map = merge(romaji_map, youon_map)

local kanatable_romaji = {}

for ck, cv in pairs(consonants) do
    for vk, vv in pairs(vowels) do
        kanatable_romaji[ck .. vk] = cv .. vv
        kanatable_romaji[ck .. "y" .. vk] = cv .. "y" .. vv
    end
end
for vk, vv in pairs(vowels) do
    kanatable_romaji[vk] = vv
end
local final_kanatable = {}

for key, romaji in pairs(kanatable_romaji) do
    local kana = to_kana(romaji, romaji_map)
    if kana and not kana:match("[a-zA-Z]") then
        final_kanatable[key] = { kana, "" }
    end
end

-- e:; i:. o:, u:( a:)
local special_exts = {
    ["k,"] = { "こと", "" },
    ["k)"] = { "から", "" },
    ["k("] = { "かも", "" },
    ["g,"] = { "ごと", "" },
    ["g)"] = { "がら", "" },
    ["s("] = { "する", "" },
    ["s)"] = { "した", "" },
    ["z("] = { "ざる", "" },
    ["t."] = { "たち", "" },
    ["t,"] = { "たび", "" },
    ["t;"] = { "ため", "" },
    ["t)"] = { "たら", "" },
    ["n("] = { "なる", "" },
    ["n."] = { "にち", "" },
    ["n)"] = { "ねば", "" },
    ["d("] = { "です", "" },
    ["d."] = { "だち", "" },
    ["d,"] = { "でも", "" },
    ["h,"] = { "ひと", "" },
    ["b,"] = { "びと", "" },
    ["m("] = { "ます", "" },
    ["m,"] = { "もの", "" },
    ["m)"] = { "また", "" },
    ["y("] = { "よる", "" },
    ["r;"] = { "られ", "" },
    ["w)"] = { "わた", "" },
    ["w;"] = { "われ", "" },
}

local specials = merge(special_exts, {
    [" "] = "henkanFirst",
    ["^"] = "henkanPoint",
    [":"] = "zenkaku",
    [";"] = "katakana",
    ["/"] = "abbrev",

    ["["] = { "「", "" },
    ["]"] = { "」", "" },
    ["-"] = { "ー", "" },
    ["x,"] = { "‥", "" },
    ["x."] = { "…", "" },
    ["x/"] = { "・", "" },
    ["x["] = { "『", "" },
    ["x]"] = { "』", "" },
    ["xt"] = { "←", "" },
    ["xn"] = { "↓", "" },
    ["xs"] = { "↑", "" },
    ["xr"] = { "→", "" },

    ["f"] = { "ん", "" },
    ["c"] = { "っ", "" },
    [","] = { "、", "" },
    ["."] = { "。", "" },
    ["wu"] = { "うぉ", "" },
})
local kanatable = merge(final_kanatable, specials)

local function serialize(t)
    local s = "return {\n"
    for k, v in pairs(t) do
        if type(v) == "table" then
            s = s .. string.format('  ["%s"] = {"%s", "%s"},\n', k, v[1], v[2] or "")
        elseif type(v) == "string" then
            s = s .. string.format('  ["%s"] = "%s",\n', k, v)
        end
    end
    s = s .. "}"
    return s
end

io.write(serialize(kanatable))
