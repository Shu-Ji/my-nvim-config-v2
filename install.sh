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

# 检查命令是否存在
check_cmd() {
  command -v "$1" &> /dev/null
}

# 安装依赖
echo ""
echo ">>> 检查依赖工具..."

if command -v brew &> /dev/null; then
  # macOS (Homebrew)
  TOOLS=""
  check_cmd nvim || TOOLS="$TOOLS neovim"
  check_cmd rg || TOOLS="$TOOLS ripgrep"
  check_cmd fd || TOOLS="$TOOLS fd"
  check_cmd tree-sitter || TOOLS="$TOOLS tree-sitter-cli"
  check_cmd stylua || TOOLS="$TOOLS stylua"
  check_cmd lazygit || TOOLS="$TOOLS lazygit"

  if [ -n "$TOOLS" ]; then
    echo "需要安装:$TOOLS"
    brew install $TOOLS 2>/dev/null || echo "Homebrew 安装失败，请手动安装"
  else
    echo "所有依赖工具已安装 ✓"
  fi

  # 安装 Nerd Font
  if [ ! -d "$(brew --prefix)/Caskroom/font-jetbrains-mono-nerd-font" ]; then
    echo "安装字体: font-jetbrains-mono-nerd-font"
    brew install --cask font-jetbrains-mono-nerd-font 2>/dev/null || echo "字体安装失败，请手动安装"
  else
    echo "字体已安装 ✓"
  fi
elif command -v apt &> /dev/null; then
  # Debian/Ubuntu
  sudo apt update
  sudo apt install -y neovim ripgrep fd-find build-essential clang libclang-dev
  # tree-sitter-cli 需要编译安装
  cargo install tree-sitter-cli 2>/dev/null || {
    echo "cargo 未安装，正在安装 rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    cargo install tree-sitter-cli
  }
elif command -v pacman &> /dev/null; then
  # Arch Linux
  sudo pacman -S --noconfirm neovim ripgrep fd tree-sitter stylua lazygit ttf-hack-nerd
elif command -v dnf &> /dev/null; then
  # Fedora
  sudo dnf install -y neovim ripgrep fd-find clang clang-devel
  # tree-sitter-cli 需要编译安装
  cargo install tree-sitter-cli 2>/dev/null || {
    echo "cargo 未安装，正在安装 rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    cargo install tree-sitter-cli
  }
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
if [[ "$OS" == "Linux" ]] && [ ! -f "$HOME/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf" ]; then
  echo ""
  echo ">>> 安装 JetBrainsMono Nerd Font..."
  FONT_DIR="$HOME/.local/share/fonts"
  mkdir -p "$FONT_DIR"

  # 下载 JetBrainsMono Nerd Font
  FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
  curl -fsSL "$FONT_URL" -o /tmp/JetBrainsMonoNerdFont.zip
  unzip -q /tmp/JetBrainsMonoNerdFont.zip -d "$FONT_DIR" 2>/dev/null || {
    echo "解压失败，请手动下载: $FONT_URL"
  }
  rm -f /tmp/JetBrainsMonoNerdFont.zip

  # 刷新字体缓存
  if command -v fc-cache &> /dev/null; then
    fc-cache -f "$FONT_DIR"
  fi
  echo "字体已安装到: $FONT_DIR"
  echo "请在终端设置中选择 'JetBrainsMono Nerd Font' 或 'JetBrainsMono Nerd Font Mono'"
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
REPO_URL="git@github.com:Shu-Ji/my-nvim-config-v2.git"
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
