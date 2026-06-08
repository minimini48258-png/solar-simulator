@echo off
cd /d "%~dp0"
echo 太陽光シミュレーターを起動します...
echo.

:: Python があれば使う
python --version >nul 2>&1
if %errorlevel% == 0 (
  echo Python でサーバーを起動中 (http://localhost:8080)
  start "" "http://localhost:8080"
  python -m http.server 8080
  goto :end
)

:: Python3 コマンドを試す
python3 --version >nul 2>&1
if %errorlevel% == 0 (
  echo Python3 でサーバーを起動中 (http://localhost:8080)
  start "" "http://localhost:8080"
  python3 -m http.server 8080
  goto :end
)

:: Node.js があれば使う
node --version >nul 2>&1
if %errorlevel% == 0 (
  echo Node.js でサーバーを起動中 (http://localhost:8080)
  start "" "http://localhost:8080"
  node -e "const h=require('http'),f=require('fs'),p=require('path');h.createServer((q,r)=>{let fp=p.join(__dirname,q.url==='/'?'index.html':q.url);f.readFile(fp,(e,d)=>{if(e){r.writeHead(404);r.end();}else{const m={'html':'text/html','js':'application/javascript','css':'text/css'};r.writeHead(200,{'Content-Type':m[fp.split('.').pop()]||'application/octet-stream'});r.end(d);}})}).listen(8080);"
  goto :end
)

echo.
echo エラー: Python または Node.js が見つかりませんでした。
echo いずれかをインストールしてから再度実行してください。
echo.
pause
:end