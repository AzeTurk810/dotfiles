--- Made by AzeTurk810
hl.window_rule({
    name = "xwayland-video-bridge-fixes",
    match = { class = "xwaylandvideobridge" },

    no_initial_focus = true,
    no_focus = true,
    no_anim = true,
    no_blur = true,
    max_size = { 1, 1 },
    opacity = 0.0,
})
hl.window_rule({
    match = { class = "^(obsidian|ekphos|notes)$" },
    workspace = "special:notes",
})
hl.window_rule({
    match = { class = "^(clipse|fsel)$" },
    float = true,
    center = true,
    size = { 900, 600 },
})
hl.window_rule({
    match = { class = "unipicker" },
    float = true,
    center = true,
    opacity = 0.85,
    size = { 900, 600 },
})
hl.window_rule({
    match = { class = "discord" },
    workspace = "special:communication",
})
hl.window_rule({
    match = { class = "endcord" },
    workspace = "special:communication",
    opacity = 0.85,
})
hl.window_rule({
    match = { class = "neomutt" },
    workspace = "special:emial",
    opacity = 0.85,
})
hl.window_rule({
    match = { class = "com.super_productivity.SuperProductivity" },
    workspace = "special:productivity",
})
