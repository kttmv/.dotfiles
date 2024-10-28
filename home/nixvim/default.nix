{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;

    globals = {
      mapleader = " ";
    };

    options = {
      number = true;
      relativenumber = true;

      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      cindent = true;

      scrolloff = 16;
      title = true;
      signcolumn = "yes";

      keymap = "russian-jcukenwin";

      iminsert = 0;
      imsearch = 0;

      #langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz";
    };

    autoCmd = [
      {
        event = [ "BufWritePost" ];
        pattern = [ "*.js" "*.ts" "*.jsx" "*.tsx" "*.json" "*.jsonc" "*.css" "*.html" ];
        command = '':silent exec "!npx prettier % --write"'';
      }
      {
        event = [ "BufWritePost" ];
        pattern = [ "*.nix" ];
        command = '':silent exec "!nixpkgs-fmt %"'';
      }
      {
        event = [ "BufWritePost" ];
        pattern = [ "*.cs" ];
        command = '':silent exec "!dotnet-csharpier %"'';
      }
    ];

    keymaps = [
      {
        key = "<leader>fs";
        action = "<cmd>Telescope session-lens<cr>";
        options.desc = "Sessions list";
      }
      {
        key = "<C-c>";
        action = ''"+y'';
        options.desc = "Copy to the system clipboard";
        mode = "v";
      }
      {
        key = "<C-v>";
        action = ''"+p'';
        options.desc = "Paste from the system clipboard";
        mode = "n";
      }
      {
        key = "<C-v>";
        action = ''"+p'';
        options.desc = "Paste from the system clipboard";
        mode = "v";
      }
      {
        key = "<C-l>";
        action = "<C-^>";
        options.desc = "Switch keyboard layout";
        mode = "i";
      }
      {
        key = "<C-v>";
        action = ''<esc>"+pa'';
        options.desc = "Paste from the system clipboard";
        mode = "i";
      }
      {
        key = "<leader>cf";
        action = "<cmd>Lspsaga finder<cr>";
        options.desc = "UI for LSP methods search result.";
      }
      {
        key = "<leader>cdn";
        action = "<cmd>Lspsaga diagnostic_jump_next<cr>";
        options.desc = "Jump to the next diagnostic";
      }
      {
        key = "<leader>cdp";
        action = "<cmd>Lspsaga diagnostic_jump_prev<cr>";
        options.desc = "Jump to the previous diagnostic";
      }
      {
        key = "<leader>cpd";
        action = "<cmd>Lspsaga peek_definition<cr>";
        options.desc = "Peek definition";
      }
      {
        key = "<leader>cpt";
        action = "<cmd>Lspsaga peek_type_definition<cr>";
        options.desc = "Peek type definition";
      }
      {
        key = "<leader>cdd";
        action = "<cmd>Lspsaga goto_definition<cr>";
        options.desc = "Go to definition";
      }
      {
        key = "<leader>cdt";
        action = "<cmd>Lspsaga peek_type_definition<cr>";
        options.desc = "Got to type definition";
      }
      {
        key = "<leader>ch";
        action = "<cmd>Lspsaga hover_doc<cr>";
        options.desc = "Hover";
      }
      {
        key = "<leader>cr";
        action = "<cmd>Lspsaga rename<cr>";
        options.desc = "Rename";
      }
      {
        key = "<leader>cci";
        action = "<cmd>Lspsaga incoming_calls<cr>";
        options.desc = "Callhierarchy incoming calls";
      }
      {
        key = "<leader>cco";
        action = "<cmd>Lspsaga outgoing_calls<cr>";
        options.desc = "Callhierarchy outgoing calls";
      }
      {
        key = "<leader>ca";
        action = "<cmd>Lspsaga code_action<cr>";
        options.desc = "Code action";
      }
      {
        key = "<leader>co";
        action = "<cmd>Lspsaga outline<cr>";
        options.desc = "Symbols outline";
      }
    ];

    clipboard.providers.wl-copy.enable = true;

    plugins = {
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = {
            action = "find_files";
            options.desc = "Find files";
          };
          "<leader>fg" = {
            action = "live_grep";
            options.desc = "Live search in files";
          };
          "<leader>fb" = {
            action = "buffers";
            options.desc = "Buffers list";
          };
          "<leader>fl" = {
            action = "lsp_document_symbols";
            options.desc = "LSP symbols";
          };
          "<leader>fh" = {
            action = "help_tags";
            options.desc = "Help tags";
          };
          "<leader>fd" = {
            action = "diagnostics";
            options.desc = "Diagnostics";
          };
        };

        settings = {
          pickers = {
            live_grep = {
              file_ignore_patterns = [ "node_modules" ".git" ".venv" ];
              additional_args = [ "--hidden" ];
            };
            find_files = {
              file_ignore_patterns = [ "node_modules" ".git" ".venv" ];
              hidden = true;
            };
          };
        };
      };

      which-key = {
        enable = true;
      };

      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          tsserver.enable = true;
          csharp-ls.enable = true;
          rust-analyzer.enable = true;
        };
      };

      lsp-format.enable = true;

      lspsaga = {
        enable = true;
        lightbulb.enable = true;
        implement.enable = true;
        callhierarchy.keys.quit = "<esc>";
        codeAction.keys.quit = "<esc>";
        definition.keys.quit = "<esc>";
        diagnostic.keys.quit = "<esc>";
        finder.keys.quit = "<esc>";
        outline.keys.quit = "<esc>";
        rename.keys.quit = "<esc>";
      };

      auto-session = {
        enable = true;
        sessionLens.loadOnSetup = true;
      };

      lspkind.enable = true;

      nvim-autopairs = { enable = true; extraOptions = { map_cr = true; }; };

      # autoclose = { enable = true; options = { autoIndent = true; pairSpaces = true; }; };


      ts-autotag.enable = true;

      treesitter.enable = true;

      #cmp = {
      #enable = true;
      #autoEnableSources = true;
      #settings = {
      #mapping = {
      #"<C-Space>" = "cmp.mapping.complete()";
      #"<C-d>" = "cmp.mapping.scroll_docs(-4)";
      #"<C-e>" = "cmp.mapping.close()";
      #"<C-f>" = "cmp.mapping.scroll_docs(4)";
      #"<CR>" = "cmp.mapping.confirm({ select = true })";
      #"<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
      #"<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      #};
      #};
      #};

      coq-nvim = {
        enable = true;
        settings.auto_start = true;
      };
    };

    extraPlugins = with pkgs.vimPlugins; [ nvim-web-devicons ];

    extraConfigLua = ''
      local symbols = { Error = "󰅙", Info = "󰋼", Hint = "󰌵", Warn = "" }

      for name, icon in pairs(symbols) do
      	local hl = "DiagnosticSign" .. name
      	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
      end
    '';
  };
}
