-- Set Leader Key
vim.g.mapleader = " "

-- In normal mode, pressing <leader>pv will execute the :Ex command, which opens the file explorer.
vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>")

-- In visual mode, pressing J will move the selected lines down by one line and reselect the moved lines.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- In visual mode, pressing K will move the selected lines up by one line and reselect the moved lines.
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- In normal mode, pressing J will join the current line with the next line, but it will also mark the cursor position before joining and return the cursor to that position after joining.
vim.keymap.set("n", "J", "mzJ`z")

-- In normal mode, pressing <C-d> will scroll down half a screen and center the cursor line.
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- In normal mode, pressing <C-u> will scroll up half a screen and center the cursor line.
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- In normal mode, pressing n will find the next match and center the cursor line.
vim.keymap.set("n", "n", "nzzzv")

-- In normal mode, pressing N will find the previous match and center the cursor line.
vim.keymap.set("n", "N", "Nzzzv")

-- In visual mode, pressing <leader>p will paste over the selected text without overwriting the unnamed register (default yank register).
vim.keymap.set("x", "<leader>p", [["_dP]])
-- In normal mode, pressing <leader>P will paste from the clipboard before the cursor
vim.keymap.set("n", "<leader>P", [["+P]])
-- In visual and select modes, pressing <leader>P will replace selection with clipboard
vim.keymap.set({ "v", "x" }, "<leader>P", [["+P]])

-- In normal and visual modes, pressing <leader>y will yank the selected text to the system clipboard.
-- In normal mode, pressing <leader>Y will yank the current line to the system clipboard.
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- In normal and visual modes, pressing <leader>d will delete the selected text without overwriting the unnamed register.
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- In insert mode, pressing <C-c> will act as <Esc>, exiting insert mode.
vim.keymap.set("i", "<C-c>", "<Esc>")

-- In normal mode, pressing Q will do nothing, effectively disabling the Q command.
vim.keymap.set("n", "Q", "<nop>")

-- In normal mode, pressing <C-f> will silently execute the command to open a new Tmux window with tmux-sessionizer.
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- In normal mode, pressing <leader>f will format the current buffer using the LSP (Language Server Protocol) formatting feature.
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)

-- In normal mode, pressing <C-k> will go to the next item in the quickfix list and center the cursor line.
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")

-- In normal mode, pressing <C-j> will go to the previous item in the quickfix list and center the cursor line.
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- In normal mode, pressing <leader>k will go to the next item in the location list and center the cursor line.
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")

-- In normal mode, pressing <leader>j will go to the previous item in the location list and center the cursor line.
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- In normal mode, pressing <leader>s will start a substitution command to replace all occurrences of the word under the cursor in the current buffer, with the cursor positioned to allow further editing of the command.
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- In normal mode, pressing <leader>x will make the current file executable by running chmod +x on it.
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- In normal mode, pressing <leader><leader> will source the current file, reloading its contents and configuration.
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
