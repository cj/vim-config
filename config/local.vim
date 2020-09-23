" elite mode
let g:elite_mode = 1

" Yank whole line
nmap Y yy

" Redo
map <silent> U :red<CR>

" To map <Esc> to exit terminal-mode:
tmap <C-o> <C-\><C-n>

highlight Normal guibg=#282C34
highlight SignColumn guibg=#282C34
highlight GitGutterChange guibg=#282C34
highlight GitGutterAdd guibg=#282C34
highlight GitGutterDelete guibg=#282C34

function! EnableCleanUI() abort
  setlocal listchars=
   \ nonumber
   \ norelativenumber
   \ nowrap
   \ winfixwidth
   \ laststatus=0
   \ noshowmode
   \ noruler
   \ scl=no
   \ colorcolumn=
  autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endfunction

if dein#tap('vim-gitgutter')
  let g:gitgutter_enabled = 0
endif

if dein#tap('coc.nvim')
  let g:lsp_auto_enable = 0

  " TextEdit might fail if hidden is not set.
  set hidden

  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Give more space for displaying messages.
  set cmdheight=2

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Don't load the defx-git plugin file, not needed
  let b:defx_git_loaded = 1

  let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-actions',
    \ 'coc-sh',
    \ 'coc-java-debug',
    \ 'coc-java',
    \ 'coc-lists',
    \ 'coc-emmet',
    \ 'coc-tasks',
    \ 'coc-pairs',
    \ 'coc-tsserver',
    \ 'coc-floaterm',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-emoji',
    \ 'coc-cssmodules',
    \ 'coc-yaml',
    \ 'coc-python',
    \ 'coc-pyright',
    \ 'coc-explorer',
    \ 'coc-svg',
    \ 'coc-prettier',
    \ 'coc-vimlsp',
    \ 'coc-xml',
    \ 'coc-yank',
    \ 'coc-json',
    \ 'coc-marketplace',
    \ 'coc-tabnine',
    \ 'coc-highlight',
    \ 'coc-eslint',
    \ 'coc-solargraph',
    \ 'coc-styled-components',
    \ 'coc-diagnostic',
    \ 'coc-tailwindcss',
    \ 'coc-git',
    \ ]

  nmap <silent> gn <Plug>(coc-rename)

  nnoremap <silent><LocalLeader>l :CocList diagnostics<CR>

  " Use <TAB> for selections ranges.
  " NOTE: Requires 'textDocument/selectionRange' support from the language server.
  " coc-tsserver, coc-python are the examples of servers that support it.
  nmap <silent> <C-V> <Plug>(coc-range-select)
  xmap <silent> <C-V> <Plug>(coc-range-select)

  nnoremap <silent><leader>i :<c-u>CocAction<CR>
  vnoremap <silent><leader>i :<c-u>CocAction<CR>

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  if has('patch8.1.1068')
    " Use `complete_info` if your (Neo)Vim version supports it.
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif
endif

if dein#tap('vim-visual-multi')
  let g:VM_maps = {}
  let g:VM_maps["Undo"] = 'u'
  let g:VM_maps["Redo"] = '<C-r>'
  let g:VM_maps['Select All']  = '<M-n>'
  let g:VM_maps['Visual All']  = '<M-n>'
  let g:VM_maps['Skip Region'] = '<C-x>'
  let g:VM_maps['Increase']    = '+'
  let g:VM_maps['Decrease']    = '-'
endif

if dein#tap('vim-floaterm')
  let g:indent_guides_exclude_filetypes = [
	  \ 'help', 'denite', 'denite-filter', 'startify',
	  \ 'vista', 'vista_kind', 'tagbar', 'nerdtree',
	  \ 'lsp-hover', 'clap_input', 'fzf', 'openterm', 'neoterm', 'calendar', 'lazygit', 'floaterm'
	  \ ]

  " Dim Inactive {{{
  " Handle focus lost and gained events
  " let g:diminactive_enable_focus = 1
  " " Use color column to help with active/inactive
  " let g:diminactive_use_colorcolumn = 1
  " }}}

  let g:floaterm_title = ''
  let g:floaterm_autoclose = 1

  function s:floatermSettings()
    call EnableCleanUI()
    " more settings
  endfunction

  nnoremap <silent><LocalLeader>t :Clap floaterm<CR>
  let g:floaterm_keymap_toggle = '<C-f>'
  let g:floaterm_keymap_kill = '<C-e>'
  let g:floaterm_keymap_next = "<C-'>"
  let g:floaterm_keymap_prev = '<C-;>'

  autocmd FileType floaterm call s:floatermSettings()

  " Open lazygit
  nnoremap <silent> <Leader>og :FloatermNew --height=0.8 --width=0.8  --name=lazygit lazygit<CR>
  nnoremap <silent> <Leader>on :FloatermNew --height=0.8 --width=0.8 --name=lazynpm lazynpm<CR>
  nnoremap <silent> <Leader>od :FloatermNew --height=0.8 --width=0.8 --name=lazydocker lazydocker<CR>
  nnoremap <silent> <Leader>oC :FloatermNew --height=0.8 --width=0.8<CR>
  nnoremap <silent> <Leader>oc :FloatermNew --height=0.5 --width=0.5 --position=bottomright<CR>
  nnoremap <silent> <Leader>oU :FloatermUpdate --height=0.8 --width=0.8 --position=center<CR>
  nnoremap <silent> <Leader>ou :FloatermUpdate --height=0.5 --width=0.5 --position=bottomright<CR>
  nnoremap <silent> <Leader>ox :FloatermHide<CR>
  nnoremap <silent> <Leader>ot :FloatermToggle<CR>
  nnoremap <silent> <Leader>ok :FloatermKill<CR>
endif
