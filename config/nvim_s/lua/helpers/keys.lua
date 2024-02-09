local fns = {}

fns.map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

fns.lsp_map = function(lhs, rhs, bufnr, desc)
    vim.keymap.set("n", lhs, rhs, { silent = true, buffer = bufnr, desc = desc })
end

fns.dap_map = function(mode, lhs, rhs, desc)
    fns.map(mode, lhs, rhs, desc)
end

fns.set_leader = function(key)
    vim.g.mapleader = key
    vim.g.maplocalleader = key
    fns.map({ "n", "v" }, key, "<nop>")
end


return fns
