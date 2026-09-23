@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo Lần đầu cần Internet để cài các gói trong Project.toml.
julia --project=julia -e "using Pkg; Pkg.instantiate()"
if errorlevel 1 goto ketthuc
julia --project=julia julia/app.jl
:ketthuc
echo.
pause
