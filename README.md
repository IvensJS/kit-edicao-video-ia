# Kit de edição de vídeo com IA (Claude Code)

6 skills do Claude Code que editam vídeos curtos pro Instagram, TikTok e Shorts sozinhas, do vídeo bruto até o arquivo final: cortam as pausas, transcrevem a fala, montam o design, colocam efeitos e renderizam em 1080x1920. O vídeo final sai sem metadados.

| Comando | Formato |
| --- | --- |
| `/agente-video-classificacao` | Ranking (Top 5, Top 10...), com os itens indo pra sua posição conforme a fala |
| `/agente-video-contraste` | Dois lados (Indico x Não indico, Tóxico x Saudável), com os exemplos arrastados pro lado do veredito |
| `/agente-video-mao-de-vaca` | Produto caro x produto barato, com foto e preço pesquisados na internet |
| `/agente-video-destampando` | NUNCA x certo, com tarjas que somem linha a linha conforme a fala |
| `/agente-video-problema-solucao` | A mesma pessoa duas vezes na tela (Amador x Profissional), juntando duas gravações num cenário só |
| `/agente-video-avaliacao` | Produtos numa escala de 3 níveis (verde, amarelo e vermelho), com a foto entrando no nível na hora da nota; aceita várias rodadas no mesmo vídeo |

## O que tem aqui

| Pasta | O que é | Pra onde vai |
| --- | --- | --- |
| `skills/` | As 6 skills (e o script que trata as fotos dos produtos) | `.claude/skills/` da sua pasta de usuário |
| `fontes/` | Poppins (700, 800, 900) e Lilita One | `hyperframes-student-kit/assets/fonts/` |
| `modelos/` | Projetos de exemplo que as skills usam como modelo de design | `hyperframes-student-kit/video-projects/` |
| `CLAUDE.md` | Regras da pasta de trabalho (onde ficam os vídeos brutos, finais e roteiros) | `Documents/projetos/app-edicao/CLAUDE.md` |
| `extras/sincronizar.sh` | Opcional: backup automático das suas skills num repositório seu do GitHub | Uma pasta sua de backup |

## O que você precisa

- Computador com Windows ou Mac (não funciona no celular).
- [Claude](https://claude.ai) com acesso ao Claude Code (app desktop, aba Code).
- [HyperFrames Student Kit](https://github.com/nateherkai/hyperframes-student-kit), o programa que monta e renderiza os vídeos (gratuito, você instala à parte).
- Conta na [ElevenLabs](https://elevenlabs.io) (transcrição e efeitos sonoros; precisa de créditos).
- Conector do [Firecrawl](https://www.firecrawl.dev) na sua conta do Claude (fotos e preços de produtos).
- Node.js 22+, Git, FFmpeg e Chrome (o próprio Claude Code instala pra você).

## Como instalar

O jeito mais fácil é pelo próprio Claude Code. Abra uma sessão no Code e cole:

> Baixa o repositório github.com/IvensJS/kit-edicao-video-ia pra pasta Documentos/projetos. Instala o Node.js 22+, o Git, o FFmpeg completo e o Chrome se faltar algum. Instala o HyperFrames Student Kit (github.com/nateherkai/hyperframes-student-kit) na minha pasta de usuário com npm ci, npm run setup e npm test. Depois copia as pastas de skills/ pra minha .claude/skills, as fontes/ pra assets/fonts do kit, os modelos/ pra video-projects do kit, cria a pasta Documentos/projetos/app-edicao com 01-brutos, 02-finais e 03-roteiros e coloca o CLAUDE.md lá. Por fim, troca SEU-USUARIO pelos caminhos deste computador em todos esses arquivos.

Depois:

1. Crie uma chave de API na ElevenLabs (perfil, API Keys) e cole no arquivo `.env` do HyperFrames Student Kit: `ELEVENLABS_API_KEY=sua_chave`. Nunca cole a chave no chat.
2. Conecte o Firecrawl em claude.ai, Configurações, Conectores.
3. Abra uma sessão nova no Code escolhendo a pasta `Documentos/projetos/app-edicao` (sempre abra por ela).
4. Coloque um vídeo em `01-brutos` e chame um dos comandos da tabela acima.

## Observações

- Os caminhos dentro das skills estão como `C:\Users\SEU-USUARIO\...`. A troca pelo seu usuário (passo de instalação acima) é obrigatória. No Mac, o Claude ajusta também o formato do caminho.
- Os vídeos ficam no seu computador: nada é enviado pra cá.
- As fontes Poppins e Lilita One são do Google Fonts, com licença livre SIL Open Font License 1.1.
- Música de fundo não entra: a ideia é escolher um áudio em alta direto no app na hora de postar.
