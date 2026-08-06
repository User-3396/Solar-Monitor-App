## Classes

### Tipos

<details><summary>detalhes</summary>

__1. Construtor Padrão (Default)__

```dart 
class Produto {
  String nome = '';
  
  // Construtor Padrão explícito
  Produto();
}
```

__2. Construtor Generativo (Generative)__

```dart
class Produto {
  final int id;
  final String nome;

  // Construtor Generativo
  Produto(this.id, this.nome);
}
```

__3. Construtores Nomeados (Named Constructors)__

Permitem criar múltiplos construtores para a mesma classe com propósitos diferentes. Útil para clareza de código ou conversão de dados.

```dart
class Produto {
  final int id;
  final String nome;

  Produto(this.id, this.nome);

  // Construtor Nomeado para criar um produto padrão vazio
  Produto.vazio() : id = 0, nome = '';
}

```

__4. Construtor de Redirecionamento (Redirecting)__

É um construtor que não possui corpo e serve apenas para encaminhar a chamada para outro construtor da mesma classe.

```dart
class Produto {
  final int id;
  final String nome;

  Produto(this.id, this.nome);

  // Redireciona para o construtor principal passando valores padrão
  Produto.anonimo() : this(0, 'Sem nome');
}
```
__5. Construtor Constante (Constant)__

Se a sua classe gera objetos que nunca mudam (imutáveis), você pode criar um construtor com a palavra-chave `const`. Todas as variáveis da classe devem ser `final`. Isso melhora o desempenho do Flutter.

```dart
class Alerta {
  final String mensagem;

  // Construtor Constante
  const Alerta(this.mensagem);
}

// Uso na interface: const Alerta('Sucesso');
```

__6. Construtor de Fábrica (Factory)__

Utilizado com a palavra-chave `factory`. Ao contrário dos construtores normais, ele __não cria obrigatoriamente__ uma nova instância da classe. Ele pode:

- Retornar uma instância existente (cache).
- Retornar uma subclasse específica.
- Ser usado para criar instâncias a partir de um JSON (muito comum em requisições HTTP).


```dart
class Produto {
  final int id;
  final String nome;

  Produto(this.id, this.nome);

  // Construtor Factory para converter JSON da API em Objeto
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      json['id'] as int,
      json['nome'] as String,
    );
  }
}
```

</details>

# Records (Tuplas do Dart 3+)

```dart 
(int, String) retornarDados() {
  return (10, 'Flutter');
}

// Uso:
var resultado = retornarDados();
print(resultado.$1); // Saída: 10
print(resultado.$2); // Saída: Flutter
```

## Records com Campos Nomeados:

```dart 
({int id, String nome}) retornarNomeado() {
  return (id: 1, nome: 'Dart');
}

// Uso:
var res = retornarNomeado();
print(res.id);   // Saída: 1
print(res.nome); // Saída: Dart
```


