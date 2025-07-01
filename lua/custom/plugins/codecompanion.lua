return {
  'olimorris/codecompanion.nvim',
  opts = {
    strategies = {
      chat = {
        adapter = 'deepseek',
        -- adapter = 'together',
      },
      inline = {
        adapter = 'mistral',
      },
      cmd = {
        adapter = 'mistral',
      },
    },
    opts = {
      stream = true,
      -- tools = true,
      -- log_level = 'TRACE', --uncomment this line to deep debug
    },
    adapters = {
      mistral = function()
        return require('codecompanion.adapters').extend('mistral', {
          name = 'codestral',
          env = {
            url = 'https://codestral.mistral.ai',
            api_key = 'cmd:python -c "from gestion_var import get_var;print(get_var(\\"CODESTRAL_API_KEY\\"),end=\\"\\")"',
            chat_url = '/v1/chat/completions',
          },
          -- handlers = {
          --   form_parameters = function(self, params, messages)
          --     -- codestral doesn't support these in the body
          --     params.stream_options = nil
          --     params.options = nil
          --
          --     return params
          --   end,
          -- },
          schema = {
            model = {
              default = 'codestral-latest',
            },
            temperature = {
              default = 0.2,
              -- mapping = 'parameters', -- not supported in default parameters.options
            },
          },
        })
      end,
      gemini = function()
        return require('codecompanion.adapters').extend('gemini', {
          env = {
            api_key = 'cmd:python -c "from gestion_var import get_var;print(get_var(\\"GEMINI_API_KEY\\"),end=\\"\\")"',
          },
        })
      end,
      deepseek = function()
        return require('codecompanion.adapters').extend('deepseek', {
          env = {
            api_key = 'cmd:python -c "from gestion_var import get_var;print(get_var(\\"DEEPSEEK_API_KEY\\"),end=\\"\\")"',
          },
          schema = {
            model = {
              default = 'deepseek-chat',
            },
            temperature = {
              default = 0.4,
              -- mapping = 'parameters', -- not supported in default parameters.options
            },
          },
        })
      end,
      together = function()
        return require('codecompanion.adapters').extend('openai_compatible', {
          env = {
            url = 'https://api.together.xyz', -- optional: default value is ollama url http://127.0.0.1:11434
            api_key = 'cmd:python -c "from gestion_var import get_var;print(get_var(\\"TOGETHER_API_KEY\\"),end=\\"\\")"',
            -- chat_url = '/v1/chat/completions', -- optional: default value, override if different
            models_endpoint = '/v1/models', -- optional: attaches to the end of the URL to form the endpoint to retrieve models
          },
          schema = {
            model = {
              default = 'meta-llama/Llama-3.3-70B-Instruct-Turbo-Free',
            },
          },
        })
      end,
      groq = function()
        return require('codecompanion.adapters').extend('openai_compatible', {
          env = {
            url = 'https://api.groq.com/openai', -- optional: default value is ollama url http://127.0.0.1:11434
            api_key = 'cmd:python -c "from gestion_var import get_var;print(get_var(\\"GROQ_API_KEY\\"),end=\\"\\")"',
            -- chat_url = '/v1/chat/completions', -- optional: default value, override if different
            models_endpoint = '/v1/models', -- optional: attaches to the end of the URL to form the endpoint to retrieve models
          },
          schema = {
            model = {
              default = 'meta-llama/llama-4-maverick-17b-128e-instruct',
            },
          },
        })
      end,
      tavily = function()
        return require('codecompanion.adapters').extend('tavily', {
          env = {
            api_key = 'cmd:python -c "from gestion_var import get_var;print(get_var(\\"TAVILY_API_KEY\\"),end=\\"\\")"',
          },
        })
      end,
      qwen = function()
        return require('codecompanion.adapters').extend('ollama', {
          name = 'qwencoder', -- Give this adapter a different name to differentiate it from the default ollama adapter
          schema = {
            model = {
              default = 'qwen2.5-coder:latest',
            },
          },
        })
      end,
    },
  },
  -- Charger quand l'utilisateur lance ces commandes
  cmd = { 'CodeCompanion', 'CodeCompanionActions', 'CodeCompanionChat', 'CodeCompanionCmd' },
  -- Charger quand l'utilisateur utilise ces raccourcis clavier
  keys = {
    { '<LocalLeader>a', '<cmd>CodeCompanionActions<CR>', mode = { 'n', 'v' }, desc = 'CodeCompanion Actions' },
    { '<LocalLeader>c', '<cmd>CodeCompanionChat Toggle<CR>', mode = { 'n', 'v' }, desc = 'Toggle CodeCompanion Chat' },
    { 'ga', '<cmd>CodeCompanionChat Add<CR>', mode = 'v', desc = 'Add to CodeCompanion Chat' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
