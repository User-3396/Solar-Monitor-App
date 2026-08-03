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

# Dispose

<details><summary>Detalhes</summary>

O método `void dispose()` deve ser utilizado __sempre que o seu widget for do tipo `StatefulWidget` e criar objetos que consomem recursos do sistema de forma contínua__.
No Flutter, o `dispose()` serve para fechar, cancelar ou limpar esses objetos antes que o widget seja destruído e removido permanentemente da árvore de widgets. Se você não fizer isso, esses objetos continuam rodando em segundo plano, gerando __vazamentos de memória (memory leaks)__ e travamentos no app.

## Quando é obrigatório ou altamente recomendável usar?

### 1. Controladores de Animação e Texto

Sempre que você instanciar controladores que interagem com a tela ou com o tempo.

- `TextEditingController` (inputs de texto)
- `AnimationController` (animações customizadas)
- `PageController` (controle de páginas/slides)
- `ScrollController` (controle de rolagem de listas)

### 2. Fluxos de Dados e Conexões (Streams)

Se você assina um canal de dados que envia atualizações contínuas, precisa fechar essa escuta.

- `StreamController` e `StreamSubscription`
- Conexões de WebSockets
- Listeners de pacotes externos (como RxDart ou canais de áudio)

### 3. Temporizadores (Timers)

Se você cria contadores ou execuções agendadas que rodam em intervalos de tempo.

- `Timer.periodic`

</details>

