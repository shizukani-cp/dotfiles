let
  stringLength = builtins.stringLength;
  substring = builtins.substring;
  romaji_map = (builtins.mapAttrs (_: v: if builtins.isList v then v else [ v "" ]) (import ./standard-kanatable.nix)) // {
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
