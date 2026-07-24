# TextField

## 1. Formatação e Restrição de Entrada

<details><summary>detalhes</summary>

- `inputFormatters`: Recebe uma lista de `TextInputFormatter`. Serve para criar máscaras (como a de data), forçar letras maiúsculas ou bloquear caracteres específicos.
- `keyboardType`: Define o tipo de teclado que abrirá no celular. Exemplos: `TextInputType.number` (numérico), `TextInputType.emailAddress` (com o símbolo @), ou `TextInputType.phone`.
- `maxLength`: Define o limite máximo de caracteres. Mostra um contador visual embaixo do campo por padrão.
- `maxLengthEnforcement`: Controla o que acontece quando o limite é atingido (se o teclado para de digitar ou apenas avança e mostra erro).

</details>

## 2. Controle de Texto e Estado

<details><summary>detalhes</summary>

- `controller`: Recebe um `TextEditingController`. É essencial para ler o que o usuário digitou, limpar o campo programaticamente ou definir um texto inicial.
- `onChanged`: Uma função callback disparada a cada caractere que o usuário digita ou apaga. Ideal para buscas em tempo real.
- `onSubmitted`: Disparada quando o usuário clica no botão de "Concluir" ou "Enviar" do teclado virtual.
- `enabled`: Recebe um booleano (true ou false). Se for falso, o campo fica cinza e desabilitado para cliques.
</details>

## 3. Visual e Estilização

<details><summary>detalhes</summary>

- `decoration`: Recebe o objeto `InputDecoration`. É onde você customiza tudo o que é visual:
  - `labelText`: O título que flutua quando o campo é focado.
  - `hintText`: O texto de exemplo (placeholder) que some ao digitar.
  - `prefixIcon` / `suffixIcon`: Ícones que aparecem no começo ou fim do campo (como o olho para ocultar senhas).
  - `border`: Define as bordas do campo (ex: `OutlineInputBorder()`).
- `style`: Altera a cor, tamanho e fonte do texto que o usuário está digitando (recebe um `TextStyle`).
- `obscureText`: Recebe um booleano. Se true, transforma o texto em pontinhos (usado para senhas).
</details>

## 4. Comportamento do Foco e Teclado

<details><summary>detalhes</summary>

- `focusNode`: Permite controlar o foco do campo programaticamente (ex: fazer o cursor pular para o próximo `TextField` ao apertar "Enter").
- `autofocus`: Se true, o campo foca e abre o teclado automaticamente assim que a tela é aberta.
- `textInputAction`: Muda o ícone do botão de ação do teclado (ex: `TextInputAction.next` exibe uma seta para avançar, `TextInputAction.search` exibe uma lupa).
- `readOnly`: Se true, o usuário consegue clicar e selecionar o texto, mas não consegue alterar nada (ótimo para campos onde o usuário escolhe a informação em um calendário ou modal).
</details>
