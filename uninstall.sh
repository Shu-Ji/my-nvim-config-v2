#!/bin/bash

# Neovim 配置卸载脚本
# 支持 macOS 和 Linux

set -e

echo "=== Neovim 配置卸载脚本 ==="

# 确认卸载
echo ""
echo "此脚本将删除:"
echo "  - ~/.config/nvim (配置文件)"
echo "  - ~/.local/share/nvim (插件和数据)"
echo "  - ~/.local/state/nvim (状态文件)"
echo "  - ~/.cache/nvim (缓存)"
echo ""
read -p "确认卸载? (y/N): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "取消卸载"
  exit 0
fi

# 删除配置
NVIM_CONFIG="$HOME/.config/nvim"
if [ -d "$NVIM_CONFIG" ]; then
  echo "删除配置: $NVIM_CONFIG"
  rm -rf "$NVIM_CONFIG"
fi

# 删除插件和数据
NVIM_DATA="$HOME/.local/share/nvim"
if [ -d "$NVIM_DATA" ]; then
  echo "删除数据: $NVIM_DATA"
  rm -rf "$NVIM_DATA"
fi

# 删除状态
NVIM_STATE="$HOME/.local/state/nvim"
if [ -d "$NVIM_STATE" ]; then
  echo "删除状态: $NVIM_STATE"
  rm -rf "$NVIM_STATE"
fi

# 删除缓存
NVIM_CACHE="$HOME/.cache/nvim"
if [ -d "$NVIM_CACHE" ]; then
  echo "删除缓存: $NVIM_CACHE"
  rm -rf "$NVIM_CACHE"
fi

# 删除备份文件 (可选)
NVIM_BACKUP="$HOME/.backup-vim"
if [ -d "$NVIM_BACKUP" ]; then
  echo ""
  read -p "删除备份文件 $NVIM_BACKUP? (y/N): " backup_confirm
  if [[ "$backup_confirm" == "y" || "$backup_confirm" == "Y" ]]; then
    rm -rf "$NVIM_BACKUP"
    echo "已删除备份"
  fi
fi

echo ""
echo "=== 卸载完成 ==="
echo ""
echo "Neovim 相关文件已全部删除"
echo "如需重新安装，运行: ~/.config/nvim/install.sh (需先克隆配置)"