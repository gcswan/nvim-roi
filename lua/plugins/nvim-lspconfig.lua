---@diagnostic disable: need-check-nil
return {
  { import = "lazyvim.plugins.extras.lang.typescript" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        marksman = {
          enabled = false,
        },
        --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
        --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
        tsserver = {
          enabled = false,
        },
        ts_ls = {
          enabled = false,
        },
        -- these settings come from the eslint docs
        -- eslint = {
        --   settings = {
        --     codeAction = {
        --       disableRuleComment = {
        --         enable = true,
        --         location = "separateLine",
        --       },
        --       showDocumentation = {
        --         enable = true,
        --       },
        --     },
        --     codeActionOnSave = {
        --       enable = false,
        --       mode = "all",
        --     },
        --     experimental = {
        --       useFlatConfig = false,
        --     },
        --     format = true,
        --     nodePath = "",
        --     onIgnoredFiles = "off",
        --     problems = {
        --       shortenToSingleLine = false,
        --     },
        --     quiet = false,
        --     rulesCustomizations = {},
        --     run = "onType",
        --     useESLintClass = false,
        --     validate = "on",
        --     workingDirectory = {
        --       mode = "location",
        --     },
        --   },
        -- },
        vtsls = {
          -- explicitly add default filetypes, so that we can extend
          -- them in related extras
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          settings = {
            workingDirectory = { mode = "auto" },
            rulesCustomizations = {},
            run = "onType",
            nodePath = "",
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              insertSpaceBeforeFunctionParenthesis = true,
              inlayHints = {
                parameterNames = { enabled = false },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                enumMemberValues = { enabled = false },
              },
            },
          },
          keys = {
            {
              "gD",
              function()
                ---@diagnostic disable-next-line: missing-parameter
                local params = vim.lsp.util.make_position_params()
                LazyVim.lsp.execute({
                  command = "typescript.goToSourceDefinition",
                  arguments = { params.textDocument.uri, params.position },
                  open = true,
                })
              end,
              desc = "Goto Source Definition",
            },
            {
              "gR",
              function()
                LazyVim.lsp.execute({
                  command = "typescript.findAllFileReferences",
                  arguments = { vim.uri_from_bufnr(0) },
                  open = true,
                })
              end,
              desc = "File References",
            },
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
            {
              "<leader>cM",
              LazyVim.lsp.action["source.addMissingImports.ts"],
              desc = "Add missing imports",
            },
            {
              "<leader>cu",
              LazyVim.lsp.action["source.removeUnused.ts"],
              desc = "Remove unused imports",
            },
            {
              "<leader>cD",
              LazyVim.lsp.action["source.fixAll.ts"],
              desc = "Fix all diagnostics",
            },
            {
              "<leader>cV",
              function()
                LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
              end,
              desc = "Select TS workspace version",
            },
          },
        },
      },
      setup = {
        --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
        --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
        tsserver = function()
          -- disable tsserver
          return true
        end,
        ts_ls = function()
          -- disable tsserver
          return true
        end,
        vtsls = function(_, opts)
          LazyVim.lsp.on_attach(function(client, buffer)
            client.commands["_typescript.moveToFileRefactoring"] = function(command, ctx)
              ---@type string, string, lsp.Range
              ---@diagnostic disable-next-line: assign-type-mismatch
              local action, uri, range = unpack(command.arguments)

              local function move(newf)
                ---@diagnostic disable-next-line: param-type-mismatch
                client.request("workspace/executeCommand", {
                  command = command.command,
                  arguments = { action, uri, range, newf },
                })
              end

              ---@diagnostic disable-next-line: param-type-mismatch
              local fname = vim.uri_to_fname(uri)
              ---@diagnostic disable-next-line: param-type-mismatch
              client.request("workspace/executeCommand", {
                command = "typescript.tsserverRequest",
                arguments = {
                  "getMoveToRefactoringFileSuggestions",
                  {
                    file = fname,
                    ---@diagnostic disable-next-line: undefined-field
                    startLine = range.start.line + 1,
                    ---@diagnostic disable-next-line: undefined-field
                    startOffset = range.start.character + 1,
                    ---@diagnostic disable-next-line: undefined-field
                    endLine = range["end"].line + 1,
                    ---@diagnostic disable-next-line: undefined-field
                    endOffset = range["end"].character + 1,
                  },
                },
                ---@diagnostic disable-next-line: param-type-mismatch
              }, function(_, result)
                ---@type string[]
                local files = result.body.files
                table.insert(files, 1, "Enter new path...")
                vim.ui.select(files, {
                  prompt = "Select move destination:",
                  format_item = function(f)
                    return vim.fn.fnamemodify(f, ":~:.")
                  end,
                }, function(f)
                  if f and f:find("^Enter new path") then
                    vim.ui.input({
                      prompt = "Enter move destination:",
                      default = vim.fn.fnamemodify(fname, ":h") .. "/",
                      completion = "file",
                    }, function(newf)
                      return newf and move(newf)
                    end)
                  elseif f then
                    move(f)
                  end
                end)
              end)
            end
          end, "vtsls")
          -- copy typescript settings to javascript
          opts.settings.javascript =
            vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
        end,
      },
    },
  },
}
