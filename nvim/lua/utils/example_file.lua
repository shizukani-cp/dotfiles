local M = {}

M.example_string = {
    "The day before yesterday was so bad day.",
    "My code exploded five times in one minute.",
    "The compiler screamed. I screamed back.",
    "My tea spilled on the keyboard, so now the spacebar says “s” sometimes.",
    "Git refused to push, like even the cloud rejected me.",
    "Even my cat left the room. It was emotional damage.",
    "I went to sleep with one eye open, afraid of runtime errors in my dreams.",
    "",
    "一昨日はほんまに最悪な日やった。",
    "コードは1分で5回爆発したし、コンパイラは叫ぶし、ワイも叫んだ。",
    "キーボードに紅茶をぶちまけたせいで、スペースキー押すと「s」が出る。",
    "Gitはpushを拒否。まるでクラウドにまで見捨てられたみたいや。",
    "猫も出ていった。心のダメージは計り知れん。",
    "夢の中でもランタイムエラーが出そうで、片目開けたまま寝た。",
    "",
    "Yesterday was even worse day.",
    "My PC refused to boot. The screen said “No signal,” like my soul.",
    "I tried to debug with my phone, but the battery died at 3%.",
    "Then I spilled water on the backup keyboard.",
    "My cat came back, looked at me, and left again — twice.",
    "At lunch, my instant noodles fell into the sink.",
    "In the evening, the internet died. I took it personally.",
    "I didn’t even have the will to cry. I just updated my resume.",
    "",
    "昨日はさらに酷かった。",
    "PCが起動せん。「No signal」って画面に出て、まるでワイの心の表示みたいや。",
    "スマホで調べようとしたら、バッテリー残量3%で死亡。",
    "代わりのキーボードにも水をこぼした。",
    "猫が戻ってきたけど、目で見て去っていった。二回も。",
    "昼飯のカップ麺はシンクに落下。",
    "夜になってネットが死んだ。もう個人的な攻撃やと思った。",
    "泣く気力もなく、履歴書を更新した。",
    "",
    "But today is so good day.",
    "I found one missing semicolon.",
    "Everything works now, like magic.",
    "The same cat that judged me yesterday is purring again.",
    "My coffee tastes like victory, not despair.",
    "I am once more the genius I always believed I was.",
    "Life is beautiful, until next bug appears.",
    "",
    "でも今日はめっちゃええ日や。",
    "抜けてたセミコロンを一個見つけた。",
    "全部動く。まるで魔法や。",
    "昨日ワイを見下してた猫が、またゴロゴロ言ってる。",
    "コーヒーの味も絶望やなくて勝利の味や。",
    "ワイは再び、自分が天才やと思い出した。",
    "次のバグが現れるまでは、人生は美しい。",
}

local function _open_scratch_buffer_with_cursor(lines)
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, buf)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(win, { 1, 0 })
    vim.api.nvim_buf_set_name(buf, '[Scratch]')
end

M.open_example = function()
    _open_scratch_buffer_with_cursor(M.example_string)
end

return M
