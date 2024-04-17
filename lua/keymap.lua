vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Move lines
vim.keymap.set('n', '<A-Up>', ':m-2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Down>', ':m+1<CR>', { noremap = true, silent = true })
-- Move selected lines up
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Indent, dedent
vim.keymap.set('n', '<tab>', ':><CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-tab>', ':<<CR>', { noremap = true, silent = true })

-- Add a new line before current line
vim.api.nvim_set_keymap('n', '<CR>', 'mzO<Esc>`z', { noremap = true, silent = true })

-- Add a new line after the current line
vim.api.nvim_set_keymap('n', '<S-CR>', 'mzo<Esc>`z', { noremap = true, silent = true })

-- Map <S-Delete> to delete the next line if it's empty
vim.api.nvim_set_keymap('n', '<Del>', ':lua delete_next_empty_line()<CR>', { noremap = true, silent = true })

function delete_next_empty_line()
  local current_line = vim.fn.line '.'
  local next_line = vim.fn.line '.' + 1
  local next_line_content = vim.fn.getline(next_line)

  -- If the next line is empty, delete it
  if next_line_content == '' then
    vim.fn.execute('normal! ' .. next_line .. 'Gdd')
  else
    -- Evaluate the current line and delete it if it's empty
    vim.fn.execute('normal! ' .. current_line .. 'G')
    vim.fn.execute 'normal! V'
    vim.fn.execute 'normal! :silent! !echo -n ""'
    local current_line_content = vim.fn.getline(current_line)
    if current_line_content == '' then
      vim.fn.execute 'normal! dd'
    end
  end

  -- Restore the cursor position to the original line
  vim.fn.execute('normal! ' .. current_line .. 'G')
end

vim.keymap.set('n', '<S-Del>', ':join<CR>', { noremap = true, silent = true })

-- Remove previous line if empty
vim.keymap.set('n', '<BS>', ':if empty(getline(line(".")-1)) | execute line(".")-1 . "delete" | endif<CR>', { noremap = true, silent = true })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
