#!/bin/bash

# Neovim 配置一键安装脚本
# 支持 macOS 和 Linux

set -e

echo "=== Neovim 配置安装脚本 ==="

# 检测系统
OS="$(uname -s)"
case "$OS" in
  Darwin)  echo "系统: macOS" ;;
  Linux)   echo "系统: Linux" ;;
  *)       echo "不支持的系统: $OS"; exit 1 ;;
esac

# 安装依赖
echo ""
echo ">>> 安装依赖工具..."

if command -v brew &> /dev/null; then
  # macOS (Homebrew)
  brew install neovim ripgrep fd-find tree-sitter-cli stylua lazygit font-hack-nerd-font 2>/dev/null || {
    echo "Homebrew 安装失败，请手动安装: neovim ripgrep fd tree-sitter-cli stylua lazygit font-hack-nerd-font"
  }
elif command -v apt &> /dev/null; then
  # Debian/Ubuntu
  sudo apt update
  sudo apt install -y neovim ripgrep fd-find
  # tree-sitter-cli 需要额外安装
  curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz" | gunzip > /tmp/tree-sitter
  sudo mv /tmp/tree-sitter /usr/local/bin/tree-sitter
  sudo chmod +x /usr/local/bin/tree-sitter
elif command -v pacman &> /dev/null; then
  # Arch Linux
  sudo pacman -S --noconfirm neovim ripgrep fd tree-sitter stylua lazygit ttf-hack-nerd
elif command -v dnf &> /dev/null; then
  # Fedora
  sudo dnf install -y neovim ripgrep fd-find
  curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz" | gunzip > /tmp/tree-sitter
  sudo mv /tmp/tree-sitter /usr/local/bin/tree-sitter
  sudo chmod +x /usr/local/bin/tree-sitter
else
  echo "无法自动安装依赖，请手动安装以下工具:"
  echo "  - neovim (>= 0.10)"
  echo "  - ripgrep"
  echo "  - fd"
  echo "  - tree-sitter-cli"
  echo "  - stylua (可选)"
  echo "  - lazygit (可选)"
  echo "  - Nerd Font (如 Hack Nerd Font)"
fi

# 安装 Nerd Font (Linux 通用方法)
if [[ "$OS" == "Linux" ]] && [ ! -f "$HOME/.local/share/fonts/HackNerdFont-Regular.ttf" ]; then
  echo ""
  echo ">>> 安装 Hack Nerd Font..."
  FONT_DIR="$HOME/.local/share/fonts"
  mkdir -p "$FONT_DIR"

  # 下载 Hack Nerd Font
  FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
  curl -fsSL "$FONT_URL" -o /tmp/HackNerdFont.zip
  unzip -q /tmp/HackNerdFont.zip -d "$FONT_DIR" 2>/dev/null || {
    echo "解压失败，请手动下载: $FONT_URL"
  }
  rm -f /tmp/HackNerdFont.zip

  # 刷新字体缓存
  if command -v fc-cache &> /dev/null; then
    fc-cache -f "$FONT_DIR"
  fi
  echo "字体已安装到: $FONT_DIR"
  echo "请在终端设置中选择 'Hack Nerd Font' 或 'Hack Nerd Font Mono'"
fi

# 备份旧配置
NVIM_DIR="$HOME/.config/nvim"
if [ -d "$NVIM_DIR" ]; then
  echo ""
  echo ">>> 备份旧配置..."
  BACKUP_DIR="$HOME/.config/nvim_backup_$(date +%Y%m%d_%H%M%S)"
  mv "$NVIM_DIR" "$BACKUP_DIR"
  echo "备份到: $BACKUP_DIR"
fi

# 克隆配置
echo ""
echo ">>> 克隆 Neovim 配置..."
mkdir -p "$NVIM_DIR"

# 从 GitHub 克隆 (替换为你的仓库地址)
REPO_URL="https://github.com/finn-wu/nvim-config.git"
if git clone "$REPO_URL" "$NVIM_DIR" 2>/dev/null; then
  echo "配置已克隆到: $NVIM_DIR"
else
  echo "克隆失败，请确保仓库地址正确: $REPO_URL"
  echo "或手动复制配置文件到 $NVIM_DIR"
  exit 1
fi

# 启动 Neovim 安装插件
echo ""
echo ">>> 安装插件..."
nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

echo ""
echo "=== 安装完成! ==="
echo ""
echo "启动命令: nvim"
echo "查看快捷键: 按 ;;"
echo "安装 LSP: 运行 :Mason 安装需要的语言服务器"
echo ""