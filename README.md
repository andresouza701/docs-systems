# Meu Projeto (MkDocs + Material)

Instruções rápidas para iniciar localmente e para deploy no GitHub Pages.

Repositório: https://github.com/andresouza701/docs-systems

Instalar dependências (recomendado dentro de um virtualenv):

```bash
python -m venv .venv
# Windows
.venv\Scripts\activate
pip install -r requirements.txt
```

Servir localmente:

```bash
mkdocs serve
```

Gerar o site (output em `site/`):

```bash
mkdocs build
```

Para publicar automaticamente no GitHub Pages, há uma GitHub Action configurada em `.github/workflows/gh-pages.yml`.
