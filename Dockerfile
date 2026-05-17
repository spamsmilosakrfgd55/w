name: 1:1 Zrcadleni webu

on:
  push: # Spustí se při pushi
  workflow_dispatch: # Umožní vám spustit zrcadlení ručně tlačítkem v GitHubu
  schedule:
    - cron: '0 * * * *' # Volitelné: Automaticky zkontroluje a zkopíruje změny každou hodinu

jobs:
  mirror:
    runs-on: ubuntu-latest
    steps:
      - name: Klonování zdrojového repozitáře (smilos71/web)
        run: |
          # Naklonuje zdrojový repozitář jako "bare" (čistá data a historie bez pracovních souborů)
          git clone --bare https://github.com mirror_repo

      - name: Nahrání 1:1 do vašeho repozitáře
        run: |
          cd mirror_repo
          # Přetlačí všechny větve a tagy 1:1 do vašeho účtu pod vaším tokenem
          git push https://x-access-token:${{ secrets.MIRROR_TOKEN }}@://github.com{{ github.repository }}.git --mirror
