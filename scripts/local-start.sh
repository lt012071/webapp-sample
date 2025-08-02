#!/bin/bash

echo "🚀 ローカル環境を開始しています..."

# プロジェクトルートディレクトリに移動
cd "$(dirname "$0")/.."

# バックエンドの起動（バックグラウンド）
echo "📦 バックエンドを起動中..."
cd backend

# 仮想環境の確認・作成
if [ ! -d "venv" ]; then
    echo "🔧 Python仮想環境を作成中..."
    python3 -m venv venv
fi

# 仮想環境の有効化
source venv/bin/activate

# 依存関係のインストール
pip install -r requirements.txt

# バックエンドサーバーをバックグラウンドで起動
uvicorn main:app --reload --host 0.0.0.0 --port 8000 &
BACKEND_PID=$!

# フロントエンドの起動
echo "🎨 フロントエンドを起動中..."
cd ../frontend

# 依存関係のインストール（初回のみ）
if [ ! -d "node_modules" ]; then
    echo "📦 Node.js依存関係をインストール中..."
    npm install
fi

# フロントエンドサーバーを起動
npm run dev &
FRONTEND_PID=$!

echo "✅ ローカル環境が起動しました"
echo "📱 フロントエンド: http://localhost:3000"
echo "🔧 バックエンド: http://localhost:8000"
echo "📚 API ドキュメント: http://localhost:8000/docs"
echo ""
echo "停止するには Ctrl+C を押すか、./scripts/local-stop.sh を実行してください"

# プロセスIDをファイルに保存
echo $BACKEND_PID > ../scripts/.backend.pid
echo $FRONTEND_PID > ../scripts/.frontend.pid

# プロセスの監視
wait