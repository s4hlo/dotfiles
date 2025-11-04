# Molten

Remote plugin for running code interactively with Jupyter kernels in Neovim. Provides REPL-like and notebook-like experiences.

## Requirements

- NeoVim 9.4+
- Python 3.10+
- Python packages: `pynvim`, `jupyter_client`
- Optional: `cairosvg`, `pnglatex`, `plotly`, `kaleido`, `pyperclip`, `nbformat`, `pillow`

## Key Features

- Async code execution in Jupyter kernel
- Real-time output as virtual text or floating window
- Image, plot, and LaTeX rendering
- Multiple buffers/kernels support
- Virtual environment support
- Import/export to/from Jupyter notebooks

## Core Commands

| Command | Description |
|---------|-------------|
| `MoltenInit` | Initialize kernel for current buffer |
| `MoltenEvaluateLine` | Evaluate current line |
| `MoltenEvaluateVisual` | Evaluate visual selection |
| `MoltenEvaluateOperator` | Evaluate operator selection |
| `MoltenReevaluateCell` | Re-run active cell |
| `MoltenDelete` | Delete active cell |
| `MoltenShowOutput` | Show output window |
| `MoltenInterrupt` | Stop currently running code |

## Configuration

Key configuration variables (defaults in parentheses):

- `g:molten_auto_open_output` (`true`) - Auto-open floating output window
- `g:molten_virt_text_output` (`false`) - Show output as virtual text
- `g:molten_image_provider` (`"none"`) - Image provider: `"image.nvim"` or `"wezterm"`
- `g:molten_image_location` (`"both"`) - Where images display: `"float"`, `"virt"`, or `"both"`
- `g:molten_tick_rate` (`500`) - Polling rate in ms for UI updates
- `g:molten_output_win_border` - Border style for output window
- `g:molten_use_border_highlights` (`false`) - Different border colors for cell states

## Keybindings

Minimum suggested mappings:

```lua
vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { silent = true })
vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", { silent = true })
vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>", { silent = true })
vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { silent = true })
vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", { silent = true })
```

## Status Line

```lua
require('molten.status').initialized() -- "Molten" or ""
require('molten.status').kernels() -- "kernel1 kernel2" or ""
require('molten.status').all_kernels() -- All kernels
```

## Output Chunks

Supported mime-types:
- `text/plain` - Plain text output
- `image/*` - Images via image.nvim
- `application/vnd.plotly.v1+json` - Plotly figures
- `text/latex` - LaTeX formulas
- `text/html` - HTML output (via browser)

## Autocommands

- `MoltenInitPre` - Before initialization
- `MoltenInitPost` - After initialization
- `MoltenDeinitPre` - Before de-initialization
- `MoltenDeinitPost` - After de-initialization
- `MoltenKernelReady` - When kernel is ready

## Highlights

- `MoltenOutputBorder` - Output window border
- `MoltenOutputBorderFail` - Failed output border
- `MoltenOutputBorderSuccess` - Success output border
- `MoltenOutputWin` - Output window content
- `MoltenCell` - Code cell highlight
- `MoltenVirtualText` - Virtual text output

## Notes

- Remote plugin: Requires proper setup for remote plugin API
- Cells are delimited by extmarks, adjust with text edits
- Overlapping cells not allowed (old cell deleted)
- Image providers: `image.nvim` (inline) or `wezterm` (split pane)
