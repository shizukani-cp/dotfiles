let
  stringLength = builtins.stringLength;
  substring = builtins.substring;

  merge = t1: t2: t1 // t2;

  consonants = {
    l = "x"; k = "k"; g = "g"; s = "s"; z = "z"; t = "t"; d = "d";
    n = "n"; h = "h"; f = "f"; b = "b"; v = "v"; p = "p"; m = "m";
    y = "y"; r = "r"; w = "w";
  };

  vowels = {
    a = "a"; i = "i"; u = "u"; e = "e"; o = "o";
    c = "ann"; h = "inn"; d = "unn"; z = "enn"; k = "onn";
    r = "ei"; t = "ai"; s = "uu"; n = "ou";
    w = "_a"; m = "_i"; g = "_u"; l = "_e"; p = "_o";
  };

  romaji_map_base = {
    a = "あ"; i = "い"; u = "う"; e = "え"; o = "お";
    xa = "ぁ"; xi = "ぃ"; xu = "ぅ"; xe = "ぇ"; xo = "ぉ";
    ka = "か"; ki = "き"; ku = "く"; ke = "け"; ko = "こ";
    ga = "が"; gi = "ぎ"; gu = "ぐ"; ge = "げ"; go = "ご";
    sa = "さ"; si = "し"; su = "す"; se = "せ"; so = "そ";
    za = "ざ"; zi = "じ"; zu = "ず"; ze = "ぜ"; zo = "ぞ";
    ta = "た"; ti = "ち"; tu = "つ"; xtu = "っ"; te = "て"; to = "と";
    da = "だ"; di = "ぢ"; du = "づ"; de = "で"; "do" = "ど";
    na = "な"; ni = "に"; nu = "ぬ"; ne = "ね"; no = "の";
    ha = "は"; hi = "ひ"; hu = "ふ"; he = "へ"; ho = "ほ";
    ba = "ば"; bi = "び"; bu = "ぶ"; be = "べ"; bo = "ぼ";
    pa = "ぱ"; pi = "ぴ"; pu = "ぷ"; pe = "ぺ"; po = "ぽ";
    fa = "ふぁ"; fi = "ふぃ"; fu = "ふ"; fe = "ふぇ"; fo = "ふぉ";
    va = "ゔぁ"; vi = "ゔぃ"; vu = "ゔ"; ve = "ゔぇ"; vo = "ゔぉ";
    ma = "ま"; mi = "み"; mu = "む"; me = "め"; mo = "も";
    ya = "や"; yu = "ゆ"; yo = "よ";
    xya = "ゃ"; xyu = "ゅ"; xyo = "ょ";
    ra = "ら"; ri = "り"; ru = "る"; re = "れ"; ro = "ろ";
    wa = "わ"; wi = "うぃ"; we = "うぇ"; wo = "を";
    nn = "ん";
    k_o = [ "こと" "" ]; k_a = [ "から" "" ]; k_u = [ "かも" "" ];
    g_o = [ "ごと" "" ]; g_a = [ "がら" "" ]; s_u = [ "する" "" ];
    s_a = [ "した" "" ]; z_u = [ "ざる" "" ]; t_i = [ "たち" "" ];
    t_o = [ "たび" "" ]; t_e = [ "ため" "" ]; t_a = [ "たら" "" ];
    n_u = [ "なる" "" ]; n_i = [ "にち" "" ]; n_a = [ "ねば" "" ];
    d_u = [ "です" "" ]; d_i = [ "だち" "" ]; d_o = [ "でも" "" ];
    h_o = [ "ひと" "" ]; b_o = [ "びと" "" ]; m_u = [ "ます" "" ];
    m_o = [ "もの" "" ]; m_a = [ "また" "" ]; y_u = [ "よる" "" ];
    r_e = [ "られ" "" ]; w_a = [ "わた" "" ]; w_e = [ "われ" "" ];
  };

  youon_map = builtins.listToAttrs (
    builtins.concatLists (
      builtins.map (
        k:
        let
          v = romaji_map_base.${k};
          c = substring 0 1 k;
          last = substring 1 1 k;
        in
        if stringLength k == 2 && last == "i" then
          [
            {
              name = "${c}ya";
              value = "${v}ゃ";
            }
            {
              name = "${c}yu";
              value = "${v}ゅ";
            }
            {
              name = "${c}ye";
              value = "${v}ぇ";
            }
            {
              name = "${c}yo";
              value = "${v}ょ";
            }
          ]
        else if stringLength k == 2 && last == "e" then
          [
            {
              name = "${c}yi";
              value = "${v}ぃ";
            }
          ]
        else
          [ ]
      ) (builtins.attrNames romaji_map_base)
    )
  );

  romaji_map = romaji_map_base // youon_map;

  to_kana =
    romaji: dict:
    let
      len = stringLength romaji;
      loop =
        i:
        if i >= len then
          ""
        else
          let
            sub3 = if i + 3 <= len then substring i 3 romaji else "";
            sub2 = if i + 2 <= len then substring i 2 romaji else "";
            sub1 = substring i 1 romaji;

            match3 = if sub3 != "" && builtins.hasAttr sub3 dict then sub3 else null;
            match2 = if match3 == null && sub2 != "" && builtins.hasAttr sub2 dict then sub2 else null;
            match1 = if match3 == null && match2 == null && builtins.hasAttr sub1 dict then sub1 else null;

            matchedKey =
              if match3 != null then
                match3
              else if match2 != null then
                match2
              else
                match1;
          in
          if matchedKey != null then
            let
              rawVal = dict.${matchedKey};
              val = if builtins.isList rawVal then builtins.elemAt rawVal 0 else rawVal;
              matchLen = stringLength matchedKey;
            in
            val + (loop (i + matchLen))
          else
            sub1 + (loop (i + 1));
    in
    loop 0;

  kanatable_romaji = builtins.listToAttrs (
    builtins.concatLists (
      builtins.map (
        ck:
        let
          cv = consonants.${ck};
        in
        builtins.concatLists (
          builtins.map (
            vk:
            let
              vv = vowels.${vk};
            in
            [
              {
                name = "${ck}${vk}";
                value = "${cv}${vv}";
              }
              {
                name = "${ck}y${vk}";
                value = "${cv}y${vv}";
              }
            ]
          ) (builtins.attrNames vowels)
        )
      ) (builtins.attrNames consonants)
    )
    ++ (builtins.map (vk: {
      name = vk;
      value = vowels.${vk};
    }) (builtins.attrNames vowels))
  );

  hasAlpha = str: builtins.match ".*[a-zA-Z].*" str != null;

  final_kanatable = builtins.listToAttrs (
    builtins.concatLists (
      builtins.map (
        key:
        let
          romaji = kanatable_romaji.${key};
          kana = to_kana romaji romaji_map;
        in
        if kana != "" && !(hasAlpha kana) then
          [
            {
              name = key;
              value = [
                kana
                ""
              ];
            }
          ]
        else
          [ ]
      ) (builtins.attrNames kanatable_romaji)
    )
  );

specials = {
    " " = "henkanFirst";
    "^" = "henkanPoint";
    ":" = "zenkaku";
    ";" = "katakana";
    "/" = "abbrev";

    "[" = [ "「" "" ];
    "]" = [ "」" "" ];
    "-" = [ "ー" "" ];
    "x," = [ "‥" "" ];
    "x." = [ "…" "" ];
    "x/" = [ "・" "" ];
    "x[" = [ "『" "" ];
    "x]" = [ "』" "" ];
    "xt" = [ "←" "" ];
    "xn" = [ "↓" "" ];
    "xs" = [ "↑" "" ];
    "xr" = [ "→" "" ];

    "q" = [ "ん" "" ];
    "c" = [ "っ" "" ];
    "," = [ "、" "" ];
    "." = [ "。" "" ];
    "wu" = [ "うぉ" "" ];
  };

in
final_kanatable // specials
