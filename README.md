# My Neovim Configuration

基于 lazy.nvim 的现代化 Neovim 配置，打造类似 VSCode/JetBrains 的编辑体验。

## 特性

- **lazy.nvim** - 现代插件管理器，懒加载支持
- **nvim-lspconfig** - 内置 LSP，智能补全、跳转、诊断
- **nvim-cmp** - 补全引擎
- **telescope** - 模糊查找（类似 VSCode Cmd+P）
- **neo-tree** - 文件树（类似 VSCode 侧边栏）
- **treesitter** - 语法高亮
- **Tokyo Night** 主题

## 快捷键 (Leader: `;`)

| 快捷键     | 功能                   |
| ---------- | ---------------------- |
| `;w`       | 保存                   |
| `;q`       | 退出                   |
| `;p`       | 查找文件               |
| `;F`       | 全局搜索               |
| `;n`       | 文件树                 |
| `;<Space>` | 注释                   |
| `;;`       | 快捷键列表 (which-key) |

## 安装

1. 安装 Neovim 0.12+
2. 安装依赖: `brew install ripgrep fd`
3. 克隆配置:
   ```bash
   git clone https://github.com/Shu-Ji/my-nvim-config-v2.git ~/.config/nvim
   ```
4. 启动 nvim，lazy.nvim 会自动安装插件

## LSP 支持

通过 Mason 安装 LSP servers:

- TypeScript/JavaScript (typescript-language-server)
- Python (pyright + ruff)
- Rust (rust-analyzer)
- Lua (lua-language-server)
- Vue/React (tailwindcss-language-server)

运行 `:Mason` 查看和安装更多。
