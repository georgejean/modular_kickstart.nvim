return {
  'olimorris/codecompanion.nvim',
  opts = {
    strategies = {
      chat = {
        adapter = 'mistral',
      },
      inline = {
        adapter = 'deepseek',
      },
      cmd = {
        adapter = 'deepseek',
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
            api_key = 'cmd:python -c "from gestion_var import get_secret;print(get_secret(\\"CODESTRAL_API_KEY\\"),end=\\"\\")"',
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
      deepseek = function()
        return require('codecompanion.adapters').extend('deepseek', {
          env = {
            api_key = 'cmd:python -c "from gestion_var import get_secret;print(get_secret(\\"DEEPSEEK_API_KEY\\"),end=\\"\\")"',
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
      groq = function()
        return require('codecompanion.adapters').extend('openai_compatible', {
          env = {
            url = 'https://api.groq.com/openai', -- optional: default value is ollama url http://127.0.0.1:11434
            api_key = 'cmd:python -c "from gestion_var import get_secret;print(get_secret(\\"GROQ_API_KEY\\"),end=\\"\\")"',
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
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
