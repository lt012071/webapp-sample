#!/bin/bash

echo "🚀 Docker環境を開始しています..."

# プロジェクトルートディレクトリに移動
cd "$(dirname "$0")/.."

# Docker Composeでサービスを起動
docker-compose up --build

echo "✅ Docker環境が起動しました"
echo "📱 フロントエンド: http://localhost:3000"
echo "🔧 バックエンド: http://localhost:8000"
echo "📚 API ドキュメント: http://localhost:8000/docs"