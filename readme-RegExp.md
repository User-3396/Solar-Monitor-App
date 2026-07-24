## RegEx (Expressão Regular)

Regex, ou expressão regular, é uma mini-linguagem usada para buscar, validar e alterar padrões de textos. Sim, existem pequenas diferenças de sintaxe e motores entre as linguagens de programação, divididas principalmente em motores POSIX, PCRE e padrões específicos do .NET ou Java.

- Padrões de texto: Usa símbolos como `\d` para números e `[a-z]` para letras.
- Validação: Confere se um e-mail ou CPF está correto.
- Busca e troca: Acha palavras específicas ou troca partes de um texto grande.

### Diferenças entre as linguagens

- __Motor de busca__: Algumas usam o padrão PCRE (PHP e Perl), enquanto Python usa o módulo próprio re e Java usa a classe `Pattern`.
- __Sintaxe dos atalhos__: Grupos de captura nomeados mudam de formato (ex: `(?<nome>...)` no .NET/JavaScript e `(P<nome>...)` em versões antigas do Python).
- __Flags e modificadores__: O jeito de ativar busca global ou ignorar letras maiúsculas/minúsculas varia na forma de escrever no código.
- __Ferramentas de apoio__: Você pode testar e comparar esses comportamentos no site Regex101 para ver como cada motor se comporta

### Dart

__Principais características no Dart:__

- __Uso do prefixo `r` (Raw String)__: Sempre use `r` antes das aspas (ex: `r'\d+'`). Isso diz ao Dart para ignorar o escape de barras invertidas, evitando que você precise digitar duas barras (`\\d`).
- __Métodos diretos__: Você não precisa de bibliotecas externas. A própria classe String do Dart já aceita Regex em métodos como `.replaceAll(RegExp, String)` ou `.split(RegExp)`.
- __Flags comuns__: Modificadores como ignorar maiúsculas/minúsculas (`caseSensitive: false`) ou busca em múltiplas linhas (`multiLine: true`) são passados como argumentos nomeados na criação do objeto.

__Componentes principais de Sintaxe (metacaracteres e classes) aceitos pelo seu motor:__

<div style="display: inline-block; width: 50%;">

- `\d` – Encontra qualquer dígito numérico (0-9).
- `\D` – Encontra qualquer caractere que não seja número.
- `\w` – Encontra caracteres alfanuméricos (letras, números e underline).
- `\W` – Encontra qualquer caractere que não seja alfanumérico.
- `\s` – Encontra espaços em branco, tabulações e quebras de linha.
- `\S` – Encontra qualquer caractere que não seja espaço.
- `\b` - Usado para identificar uma palavra isolada e garantir que seja uma palavra completa.

</div>
<div style="display: inline-block; width: 50%;">

- `.` – Encontra qualquer caractere individual (exceto quebra de linha).
- `^` – Indica o início de uma linha ou texto.
- `$` – Indica o fim de uma linha ou texto.
- `*` – Quantificador: encontra 0 ou mais repetições do padrão anterior.
- `+` – Quantificador: encontra 1 ou mais repetições do padrão anterior.
- `?` – Quantificador: encontra 0 ou 1 repetição (torna o padrão opcional).

</div>
<div style="display: inline-block; width: 50%;">

- `{n,m}` – Quantificador: encontra de n a m repetições do padrão.
- `[abc]` – Conjunto: encontra qualquer caractere que esteja dentro dos colchetes.
- `[^abc]` – Conjunto negado: encontra qualquer caractere que não esteja nos colchetes.
- `(abc)` – Grupo de captura: agrupa múltiplos caracteres e isola o resultado.

</div>
<div style="display: inline-block; width: 50%;">

- `[a-zA-Z]{3}` - Encontra uma sequência de exatamente 3 letras, sejam maiúsculas ou minúsculas.
- `\d{5}-\d{4}` - Encontra números de telefone no formato "12345-1234".
- `^Oi` - Encontra a palavra "Oi" apenas se estiver no início de uma linha ou string.
- `^[A-Z]` - O primeiro caractere da string deve ser uma letra maiúscula.
- `^[^0-9]` - O primeiro caractere da string não deve ser um dígito.
- `palavras?` - Significa que o último caractere (s) é opcional, correspondendo a "palavra" ou "palavras".
- `azulad.` - corresponderia a "azulado", "azulada", "azulad0".
- `loo+nge` - corresponderia a "loonge", "loooooooonge".
<div>

__Usos de Matches__:

- __Criar padrão__: Use strings literais brutas com `r''` para evitar problemas com barras invertidas. Exemplo: `final reg = RegExp(r'^[a-z]+$');`
- __Verificar correspondência__: `reg.hasMatch('texto')` retorna um valor booleano (true ou false).
- __Encontrar o primeiro match__: `reg.firstMatch('texto')` retorna um objeto do tipo `RegExpMatch` ou `null`.
- __Encontrar todas as ocorrências__: `reg.allMatches('texto')` retorna um iterável com todos os resultados encontrados.
