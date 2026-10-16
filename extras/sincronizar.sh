#!/usr/bin/env bash
# Copia as skills de edição, a memória e o CLAUDE.md pra este repositório,
# confere se não tem chave de API nos arquivos e envia pro GitHub.
# Roda sozinho depois de cada edição do Claude (hook) e de hora em hora (Agendador do Windows).
# Uso manual: bash sincronizar.sh "mensagem opcional"

REPO="/c/Users/SEU-USUARIO/Documents/projetos/skills-edicao-video"
SKILLS="/c/Users/SEU-USUARIO/.claude/skills"
MEMORIA="/c/Users/SEU-USUARIO/.claude/projects/C--Users-SEU-USUARIO-Documents-projetos-app-edicao/memory"
CLAUDEMD="/c/Users/SEU-USUARIO/Documents/projetos/app-edicao/CLAUDE.md"
GH="/c/Program Files/GitHub CLI/gh.exe"
LOG="$REPO/.sincronizar.log"

cd "$REPO" || exit 0

# Uma sincronização por vez
exec 9>"$REPO/.git/sincronizar.lock" 2>/dev/null
command -v flock >/dev/null && { flock -n 9 || exit 0; }

# 1. Copiar (espelho: o que foi apagado lá some aqui também)
# Todas as skills de edição (agente-video-*), sempre copiadas de novo pra pegar qualquer mudança
mkdir -p skills
for d in "$SKILLS"/agente-video-*; do
  [ -d "$d" ] || continue
  s=$(basename "$d"); rm -rf "skills/$s"; cp -r "$d" "skills/$s"
done
rm -rf memoria; mkdir -p memoria; cp "$MEMORIA"/*.md memoria/ 2>/dev/null
cp "$CLAUDEMD" CLAUDE-app-edicao.md 2>/dev/null

# Fontes do kit (Poppins, Lilita One + licença)
KIT="/c/Users/SEU-USUARIO/hyperframes-student-kit"
mkdir -p fontes; cp "$KIT"/assets/fonts/* fontes/ 2>/dev/null

# Projetos de referência que as skills usam como modelo: só design, cortes e sons (sem vídeo)
for p in palavras-traumatizam vende-ou-viraliza mao-de-vaca-edicao destampando-0004 contraste-4644 problema-solucao-gravar avaliacao-5332 editado-por-ia; do
  src="$KIT/video-projects/$p"; [ -d "$src" ] || continue
  mkdir -p "referencias/$p/assets/sfx"
  for f in index.html DESIGN.md cuts.json meta.json; do [ -f "$src/$f" ] && cp "$src/$f" "referencias/$p/"; done
  cp "$src"/assets/sfx/*.mp3 "$src"/assets/sfx/*.json "referencias/$p/assets/sfx/" 2>/dev/null
done

# 2. Tem mudança?
git add -A
if git diff --cached --quiet; then exit 0; fi

# 3. Conferir chaves antes de enviar
if git diff --cached -U0 | grep -E -i \
  'sk-ant-[a-z0-9_-]{10,}|sk-[a-z0-9]{20,}|gh[pousr]_[A-Za-z0-9]{20,}|xi-api-key["'"'"' :=]+[A-Za-z0-9]{16,}|(ELEVENLABS|KIE|FIRECRAWL|OPENAI|ANTHROPIC)_API_KEY *= *["'"'"']?[A-Za-z0-9_-]{12,}|fc-[a-f0-9]{24,}' >/dev/null; then
  git reset -q
  echo "$(date '+%F %T') BLOQUEADO: parece ter uma chave de API nos arquivos. Nada foi enviado." >> "$LOG"
  exit 0
fi

# 4. Salvar e enviar
ARQS=$(git diff --cached --name-only | sed 's#^skills/##; s#/SKILL.md##' | sort -u | head -5 | tr '\n' ' ')
MSG="${1:-Atualiza: $ARQS}"
git commit -q -m "$MSG" && echo "$(date '+%F %T') salvo: $MSG" >> "$LOG"
git push -q origin main >> "$LOG" 2>&1 || echo "$(date '+%F %T') ERRO ao enviar (vai tentar de novo na próxima)" >> "$LOG"
exit 0
