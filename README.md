# Solar Monitor Lab

## 1. Redimensionamento

```dart
// largura do componente preenchendo a largura do elemento pai
Container(
  width: double.infinity
)

// definindo por porcentagem:
FractionallySizedBox(
  widthFactor: 0.5, // 0.5 equivale a 50%
  child: Container(
    color: Colors.red,
  ),
)

```

### Porcentagem baseada no tamanho da tela

```dart
double larguraDaTela = MediaQuery.of(context).size.width;

Container(
  width: larguraDaTela * 0.40, // 40% da largura da tela
  color: Colors.green,
)
```

<details><summary>MediaQuery</summary>

O MediaQuery é um widget especial do Flutter que atua como um __provedor de informações sobre o hardware e o ambiente do dispositivo__. Ele fica no topo da árvore de componentes do aplicativo e monitora dados como:

- __Tamanho e resolução da tela__.
- __Orientação do dispositivo__ (Retrato/Portrait ou Paisagem/Landscape).
- __Configurações de acessibilidade__ (como o tamanho da fonte global que o usuário escolheu no sistema).
- __Recortes de tela__ (o famoso notch ou a barra de navegação inferior do sistema).
- __Modo de cor do sistema__ (Tema claro ou escuro).

</details>

### Componentes dentro de Row ou Column

```dart 
Row(
  children: [
    Container(width: 50, color: Colors.yellow),
    Expanded(
      child: Container(
        color: Colors.orange, // Esse container vai ocupar todo o resto da tela
      ),
    ),
  ],
)
```

## 2. Alinhamentos

- __MainAxisAlignment__ (eixo principal)
- __CrossAxisAlignment__ (eixo cruzado)
- classe __Alignment__ (posicionamento absoluto ou relativo).

O comportamento muda dependendo se você está organizando elementos em lista (como `Row` e `Column`) 
ou posicionando um elemento dentro de outro (como `Container` ou `Stack`).

### Principais opções de `MainAxisAlignment` (Eixo Principal)

- `start`: Alinha os filhos no início do eixo (padrão).
- `end`: Empurra todos os filhos para o final do eixo.
- `center`: Concentra todos os filhos no centro.
- `spaceBetween`: Coloca espaço igual entre os filhos (o primeiro e o último colam nas bordas).
- `spaceAround`: Coloca espaço igual ao redor de cada filho (o espaço nas bordas é metade do espaço entre os elementos).
- `spaceEvenly`: Distribui os espaços de forma totalmente idêntica entre os filhos e as bordas.

### Principais opções de `CrossAxisAlignment` (Eixo Cruzado)

- `start`: Alinha os filhos no início do eixo perpendicular.
- `end`: Alinha os filhos no final do eixo perpendicular.
- `center`: Centraliza os filhos perpendicularmente (padrão).
- `stretch`: Estica os filhos para ocuparem toda a largura/altura permitida no eixo cruzado.

### Alinhamento usando a classe `Alignment`

Quando você precisa alinhar um filho dentro de um `Container`, `Align` ou `Stack`, usa-se a propriedade alignment com coordenadas cartesianas virtuais que vão de -1.0 a 1.0.

__Constantes Prontas__

- `Alignment.topLeft`: Topo esquerdo `(-1.0, -1.0)`
- `Alignment.topCenter`: Topo centro `(0.0, -1.0)`
- `Alignment.topRight`: Topo direito `(1.0, -1.0)`
- `Alignment.centerLeft`: Centro esquerdo `(-1.0, 0.0)`
- `Alignment.center`: Centro exato `(0.0, 0.0)`
- `Alignment.centerRight`: Centro direito `(1.0, 0.0)`
- `Alignment.bottomLeft`: Baixo esquerdo `(-1.0, 1.0)`
- `Alignment.bottomCenter`: Baixo centro `(0.0, 1.0)`
- `Alignment.bottomRight`: Baixo direito `(1.0, 1.0)`

```dart
Align(
  alignment: Alignment(0.5, -0.2), // X = 0.5 (um pouco para a direita), Y = -0.2 (um pouco para cima)
  child: MeuWidget(),
)
```

### Alinhamento em Stack (Sobreposição)

O widget `Stack` empilha componentes uns sobre os outros. Você pode definir um alinhamento padrão para todos os filhos usando a propriedade `alignment` (que aceita os mesmos valores da classe Alignment explicada acima).
Para um controle ainda mais preciso e individual dentro do `Stack`, usa-se o widget `Positioned`, onde você define a distância exata em pixels das bordas:

```dart
Stack(
  children: [
    Container(color: Colors.blue),
    Positioned(
      bottom: 20, // 20 pixels de distância da borda inferior
      right: 15,  // 15 pixels de distância da borda direita
      child: BotaoFlutuante(),
    )
  ],
)
```

## 3. Integração com HTML

### Renderizar textos com tags HTML (Bold, Links, Itálico)

Se o seu objetivo é exibir textos formatados vindos de um banco de dados ou de uma API (ex: `<b>Texto em negrito</b>`), você não precisa de uma página web inteira.
Basta usar pacotes que convertem essas tags diretamente em widgets nativos do Flutter (`Text`, `RichText`).

- __Como fazer__: Utilize o pacote [flutter_html](https://pub.dev/packages/flutter_html) ou [flutter_widget_from_html](https://pub.dev/packages/flutter_widget_from_html).
- __Resultado__: O Flutter lê as tags simples e renderiza o texto com a formatação correta em qualquer plataforma (Web, Android, iOS), sem perda de performance.

```dart 
// Exemplo com flutter_widget_from_html
HtmlWidget(
  '<h3>Título em HTML</h3><p>Este é um parágrafo com um <a href="https://flutter.dev">link</a>.</p>',
)
```

### Integração profunda no Flutter Web (Elementos HTML reais)

Se você está criando um aplicativo para a Web, o Flutter possui uma ferramenta nativa chamada `HtmlElementView`. Ela permite injetar elementos HTML reais (como `<div>`, `<video>`, `<iframe>`, ou scripts customizados) diretamente no meio do seu layout Flutter.

- __Como funciona__: Você registra uma fábrica de elementos HTML usando a biblioteca `dart:ui_web` (antiga `dart:ui`) e a exibe como se fosse um widget comum do Flutter.
- __Exemplo prático (Inserir um iframe ou elemento de texto HTML)__:

```dart
import 'dart:ui_web' as ui_web;
import 'package:web/web.dart' as web; // Biblioteca moderna para interagir com o navegador
// ...

// 1. Registre o elemento HTML (geralmente no initState)
ui_web.platformViewRegistry.registerViewFactory(
  'meu-elemento-html',
  (int viewId) {
    final elemento = web.HTMLParagraphElement();
    elemento.text = 'Este é um parágrafo HTML real rodando no Flutter Web!';
    elemento.style.color = 'blue';
    return elemento;
  },
);

// 2. Use no seu método build:
SizedBox(
  width: 300,
  height: 50,
  child: HtmlElementView(viewType: 'meu-elemento-html'),
)
```

### Exibir páginas web completas (WebViews no Mobile)

Se você precisa exibir um site inteiro ou um sistema complexo em HTML/JS dentro do seu aplicativo para Android ou iOS, a solução é usar um componente de tela cheia ou parcial de navegador.

- __Como fazer__: Utilize o pacote oficial [webview_flutter](https://pub.dev/packages/webview_flutter) mantido pela equipe do Flutter.
- __Como funciona__: Ele abre uma instância do navegador nativo do sistema (Chromium no Android / WebKit no iOS) "mascarada" dentro de um widget do Flutter. Você pode carregar um link externo ou uma string com um código HTML completo.

### Resumo das limitações importantes

- __Não é um substituto de layout__: Você não pode criar a estrutura visual do seu aplicativo Flutter usando HTML/CSS tradicional. O Flutter usa seu próprio motor de renderização gráfica.
- __Performance__: Injetar muito HTML dentro do Flutter Mobile (via WebView) ou do Flutter Web (via muitos `HtmlElementView`) pode deixar o aplicativo pesado e causar lentidão nas animações, pois exige que dois motores gráficos trabalhem juntos.
