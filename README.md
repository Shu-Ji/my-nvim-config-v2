# My Neovim Configuration

基于 lazy.nvim 的现代化 Neovim 配置，打造类似 VSCode 的编辑体验。

## 一键安装

```bash
curl -fsSL https://raw.githubusercontent.com/Shu-Ji/my-nvim-config-v2/master/install.sh | bash
```

或手动安装：

```bash
git clone https://github.com/Shu-Ji/my-nvim-config-v2.git ~/.config/nvim
cd ~/.config/nvim && ./install.sh
```

## 特性

- **lazy.nvim** - 现代插件管理器
- **nvim-lspconfig** + **mason** - LSP 支持
- **nvim-cmp** - 补全引擎
- **telescope** - 模糊查找
- **neo-tree** - 文件树（启动自动打开）
- **bufferline** - 顶部 Tab 栏
- **treesitter** - 语法高亮
- **Tokyo Night** 主题

## 快捷键 (Leader: `;`)

按 `;;` 查看所有快捷键。

| 快捷键 | 功能 |
|--------|------|
| `;w` | 保存 |
| `;q` | 退出全部 |
| `;p` | 查找文件 |
| `;F` | 全局搜索 |
| `;n` | 文件树 |
| `;N` | 定位当前文件 |
| `;<Space>` | 注释 |
| `;j` | 快速跳转 |
| `;u` | 撤销历史 |
| `<Left>`/`<Right>` | 切换 Tab |
| `;tn` | 新建 Tab |
| `;bd` | 关闭 Tab |

## LSP 支持

自动安装：
- TypeScript/JavaScript
- Python (pyright)
- Rust (rust-analyzer)
- Lua
- Tailwind CSS

运行 `:Mason` 安装更多。

## 卸载

```bash
~/.config/nvim/uninstall.sh
```