return function(pname)
    return vim.fs.joinpath(vim.fn.expand("$PROJECTS_DIR"), pname)
end
