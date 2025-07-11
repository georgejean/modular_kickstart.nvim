return {
  'olimorris/codecompanion.nvim',
  opts = {
    strategies = {
      chat = {
        -- adapter = 'gemini',
        adapter = 'githubmodels',
        -- adapter = 'deepseek',
        -- adapter = 'mistral',
      },
      inline = {
        adapter = 'deepseek',
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
            api_key = 'cmd:python -c "from gestion_pass import get_pass;print(get_pass(\\"CODESTRAL_API_KEY\\"),end=\\"\\")"',
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
            api_key = 'cmd:python -c "from gestion_pass import get_pass;print(get_pass(\\"GEMINI_API_KEY\\"),end=\\"\\")"',
          },
          schema = {
            model = {
              default = 'gemini-2.5-pro',
              choices = {
                ['gemini-2.5-pro'] = { opts = { can_reason = true, has_vision = true } },
                ['gemini-2.5-flash'] = { opts = { can_reason = true, has_vision = true } },
                ['gemini-2.0-flash'] = { opts = { has_vision = true } },
                ['gemini-2.0-flash-lite'] = { opts = { has_vision = true } },
                ['gemini-1.5-pro'] = { opts = { has_vision = true } },
                ['gemini-1.5-flash'] = { opts = { has_vision = true } },
              },
            },
          },
        })
      end,
      deepseek = function()
        return require('codecompanion.adapters').extend('deepseek', {
          env = {
            api_key = 'cmd:python -c "from gestion_pass import get_pass;print(get_pass(\\"DEEPSEEK_API_KEY\\"),end=\\"\\")"',
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
            api_key = 'cmd:python -c "from gestion_pass import get_pass;print(get_pass(\\"TOGETHER_API_KEY\\"),end=\\"\\")"',
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
            api_key = 'cmd:python -c "from gestion_pass import get_pass;print(get_pass(\\"GROQ_API_KEY\\"),end=\\"\\")"',
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
            api_key = 'cmd:python -c "from gestion_pass import get_pass;print(get_pass(\\"TAVILY_API_KEY\\"),end=\\"\\")"',
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
      githubmodels = function()
        return require('codecompanion.adapters').extend('githubmodels', {
          env = {
            api_key = 'cmd:python -c "from gestion_pass import get_pass;print(get_pass(\\"GITHUB_TOKEN\\"),end=\\"\\")"',
          },
          schema = {
            model = {
              default = 'gpt-4.1',
              choices = {
                ['o3-mini'] = { opts = { can_reason = true } },
                ['o1'] = { opts = { can_reason = true } },
                ['o1-mini'] = { opts = { can_reason = true } },
                'gpt-4.1',
                'gpt-4o',
                'gpt-4o-mini',
                'DeepSeek-R1',
                'Codestral-2501',
                'grok-3',
                'AI21-Jamba-1.5-Large',
              },
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
