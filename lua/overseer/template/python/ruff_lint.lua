local overseer = require("overseer")

return {
  name = "Ruff Lint",
  tags = { overseer.TAG.BUILD },
  builder = function()
    return {
      cmd = { "ruff" },
      args = {
        "check",
        "--output-format",
        "concise",
        -- optional, but nice in repos:
        -- "--force-exclude",
      },
      components = {
        "default",
        {
          "on_output_parse",
          parser = {
            diagnostics = {
              {
                "extract_efm",
                {
                  -- Ruff concise format:
                  -- path/to/file.py:12:34: D104 Missing docstring in public package
                  "%f:%l:%c: %m",
                },
              },
            },
          },
        },
        {
          "on_result_diagnostics",
          remove_on_restart = true,
        },
        {
          "on_result_diagnostics_quickfix",
          open = true,
        },
      },
    }
  end,
  condition = {
    filetype = { "py", "python" },
  },
}

