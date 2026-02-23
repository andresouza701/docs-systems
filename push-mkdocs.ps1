param(
    [string]$RepoUrl = "https://github.com/andresouza701/docs-systems.git"
)

Write-Output "Repo URL: $RepoUrl"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git não encontrado. Instale Git: https://git-scm.com/download/win"
    exit 1
}

if (-not (Test-Path .git)) {
    Write-Output "Inicializando repositório Git local..."
    git init -b main
} else {
    Write-Output ".git já existe. Pulando git init."
}

$userName = git config user.name
if (-not $userName) {
    git config user.name "Seu Nome"
    Write-Output "Configurado user.name para 'Seu Nome' (edite conforme necessário)."
}
$userEmail = git config user.email
if (-not $userEmail) {
    git config user.email "seu@email.com"
    Write-Output "Configurado user.email para 'seu@email.com' (edite conforme necessário)."
}

git add .

# Verifica se há commits
git rev-parse --verify HEAD 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Output "Fazendo commit inicial..."
    git commit -m "Initial commit: MkDocs site with Material theme"
} else {
    Write-Output "Criando commit de atualização (se houver mudanças)..."
    git commit -m "Update site" --allow-empty 2>$null | Out-Null
}

try {
    git remote get-url origin 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Output "Adicionando remote origin -> $RepoUrl"
        git remote add origin $RepoUrl
    } else {
        Write-Output "Remote origin já existe. Atualizando URL para $RepoUrl"
        git remote set-url origin $RepoUrl
    }
} catch {
    Write-Output "Configurando remote origin -> $RepoUrl"
    git remote add origin $RepoUrl
}

git branch -M main

Write-Output "Enviando para GitHub (push)..."
git push -u origin main

Write-Output "Concluído. Se houver problemas de autenticação, verifique suas credenciais do Git/GitHub."
