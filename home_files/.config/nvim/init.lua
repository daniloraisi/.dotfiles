pcall(require, "config.env")

require("config.lazy")({
    debug = false,
    profilling = {
        loader = false,
        require = false,
    },
})

require("util.dashboard").setup()