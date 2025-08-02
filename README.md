# Next.js + Python Web App Sample

Next.js (フロントエンド) と Python FastAPI (バックエンド) を使用したWebアプリケーションのサンプルプロジェクトです。
ローカル開発環境とDocker環境の両方に対応しています。

## プロジェクト構成

```
webapp-sample/
├── frontend/          # Next.js フロントエンド
│   ├── src/
│   ├── package.json
│   └── Dockerfile
├── backend/           # Python FastAPI バックエンド
│   ├── main.py
│   ├── requirements.txt
│   └── Dockerfile
├── docker-compose.yml # Docker Compose設定
├── scripts/          # 開発用スクリプト
└── README.md
```

## 技術スタック

### フロントエンド
- Next.js 15 (App Router)
- TypeScript
- Tailwind CSS
- ESLint

### バックエンド
- Python 3.11
- FastAPI
- Uvicorn ASGI サーバー
- CORS対応

## セットアップと実行

### 1. Docker環境での実行 (推奨)

**前提条件:**
- Docker Desktop がインストールされていること

```bash
# プロジェクトルートで実行
docker-compose up --build

# バックグラウンド実行の場合
docker-compose up -d --build
```

**アクセス:**
- フロントエンド: http://localhost:3000
- バックエンドAPI: http://localhost:8000
- API ドキュメント: http://localhost:8000/docs

**停止:**
```bash
docker-compose down
```

### 2. ローカル環境での実行

**前提条件:**
- Node.js 18以上
- Python 3.11以上
- npm または yarn

#### バックエンドの起動

```bash
cd backend

# 仮想環境作成 (初回のみ)
python -m venv venv

# 仮想環境有効化
# macOS/Linux:
source venv/bin/activate
# Windows:
# venv\Scripts\activate

# 依存関係インストール
pip install -r requirements.txt

# サーバー起動
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

#### フロントエンドの起動

```bash
cd frontend

# 依存関係インストール (初回のみ)
npm install

# 開発サーバー起動
npm run dev
```

## 開発用スクリプト

便利な開発用スクリプトを提供しています：

```bash
# Docker環境の開始
./scripts/docker-start.sh

# Docker環境の停止
./scripts/docker-stop.sh

# ローカル環境の開始
./scripts/local-start.sh

# ローカル環境の停止
./scripts/local-stop.sh
```

## API エンドポイント

### ユーザー関連
- `GET /api/users` - ユーザー一覧取得
- `GET /api/users/{user_id}` - 特定ユーザー取得
- `POST /api/users` - ユーザー作成

### その他
- `GET /` - ルートエンドポイント
- `GET /health` - ヘルスチェック
- `GET /docs` - API ドキュメント (Swagger UI)

## 開発のポイント

### CORS設定
バックエンドでは、フロントエンド（http://localhost:3000）からのアクセスを許可するようCORSが設定されています。

### ホットリロード
- フロントエンド: ファイル変更時に自動リロード
- バックエンド: `--reload` オプションによる自動リロード

### データ永続化
現在のサンプルではメモリ内でデータを管理しています。実際のアプリケーションではデータベースを使用してください。

## トラブルシューティング

### ポート競合
- フロントエンド（3000番）またはバックエンド（8000番）ポートが使用中の場合は、該当プロセスを停止してください

### Docker関連
```bash
# イメージを再ビルド
docker-compose build --no-cache

# ボリューム削除
docker-compose down -v

# 全てのコンテナとイメージを削除
docker system prune -a
```

### 依存関係の問題
```bash
# Node.js依存関係の再インストール
cd frontend
rm -rf node_modules package-lock.json
npm install

# Python依存関係の再インストール
cd backend
pip install --upgrade -r requirements.txt
```

## ライセンス

このプロジェクトはサンプル用途として提供されています。