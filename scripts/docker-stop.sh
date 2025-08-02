#!/bin/bash

echo "🛑 Docker環境を停止しています..."

# プロジェクトルートディレクトリに移動
cd "$(dirname "$0")/.."

# Docker Composeでサービスを停止
docker-compose down

echo "✅ Docker環境が停止しました"