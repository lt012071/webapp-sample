#!/bin/bash

echo "🛑 ローカル環境を停止しています..."

# プロジェクトルートディレクトリに移動
cd "$(dirname "$0")/.."

# PIDファイルの場所
BACKEND_PID_FILE="scripts/.backend.pid"
FRONTEND_PID_FILE="scripts/.frontend.pid"

# バックエンドプロセスの停止
if [ -f "$BACKEND_PID_FILE" ]; then
    BACKEND_PID=$(cat "$BACKEND_PID_FILE")
    if ps -p $BACKEND_PID > /dev/null 2>&1; then
        echo "📦 バックエンドプロセス (PID: $BACKEND_PID) を停止中..."
        kill $BACKEND_PID
    fi
    rm -f "$BACKEND_PID_FILE"
fi

# フロントエンドプロセスの停止
if [ -f "$FRONTEND_PID_FILE" ]; then
    FRONTEND_PID=$(cat "$FRONTEND_PID_FILE")
    if ps -p $FRONTEND_PID > /dev/null 2>&1; then
        echo "🎨 フロントエンドプロセス (PID: $FRONTEND_PID) を停止中..."
        kill $FRONTEND_PID
    fi
    rm -f "$FRONTEND_PID_FILE"
fi

# 追加的にポートを使用しているプロセスを停止
echo "🔍 残存プロセスをチェック中..."
lsof -ti:3000 | xargs kill -9 2>/dev/null || true
lsof -ti:8000 | xargs kill -9 2>/dev/null || true

echo "✅ ローカル環境が停止しました"