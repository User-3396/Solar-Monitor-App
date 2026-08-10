### Helioviewer (api.helioviewer.org)

Para criar e baixar um vídeo solar da API do Helioviewer, você precisará usar um fluxo assíncrono de três etapas via código: enfileirar a solicitação (`queueMovie`), checar o status (`getMovieStatus`) até a renderização terminar e, por fim, baixá-lo (`downloadMovie`).
Siga este passo a passo para gerar seu vídeo:

1. __Envie a solicitação (Queue Movie)__

Faça uma requisição POST ou GET para o endpoint `queueMovie` com as datas e os IDs das camadas que deseja. [[1](https://api.helioviewer.org/docs/v2/api/api_groups/movies.html)]

- __Parâmetros obrigatórios__: `start` (data inicial em ISO 8601), `end` (data final) e `events` ou `layers`.
- Você receberá um JSON de resposta contendo um id único do filme.

2. __Verifique o status do vídeo__

A renderização é assíncrona. Periodicamente, envie o ID para o endpoint `getMovieStatus`.

- Continue checando até que a propriedade `status` mude para completed.

3. __Baixe o arquivo (Download Movie)__

Quando o status estiver finalizado, chame a rota downloadMovie passando o seu id como parâmetro. A API retornará o arquivo binário do vídeo (geralmente .mp4).


```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> gerarEBaixarVideoSolar() async {
  final baseUrl = Uri.parse('https://helioviewer.org');

  // 1. ENFILEIRAR O VÍDEO (queueMovie)
  final queueUrl = baseUrl.replace(path: '${baseUrl.path}queueMovie/');
  final queueResponse = await http.post(queueUrl, body: {
    'startTime': '2026-01-01T00:00:00Z',
    'endTime': '2026-01-01T06:00:00Z',
    'layers': '[1,current,1,100]', // Exemplo de ID de camada válida do Helioviewer
    'cadence': '60',
    'movieType': 'mp4',
  });

  if (queueResponse.statusCode != 200) return null;
  final queueData = jsonDecode(queueResponse.body);
  final int movieId = queueData['id'];

  // 2. VERIFICAR STATUS (getMovieStatus)
  final statusUrl = baseUrl.replace(path: '${baseUrl.path}getMovieStatus/');
  bool estaPronto = false;

  while (!estaPronto) {
    // Aguarda 5 segundos antes de checar novamente para não sobrecarregar o servidor
    await Future.delayed(Duration(seconds: 5));

    final statusResponse = await http.get(Uri.parse('$statusUrl?id=$movieId'));
    if (statusResponse.statusCode == 200) {
      final statusData = jsonDecode(statusResponse.body);
      
      // Ajuste a checagem conforme a string exata de retorno da API (geralmente "completed" ou status numérico)
      if (statusData['status'] == 'completed' || statusData['status'] == 0) {
        estaPronto = true;
      }
    }
  }

  // 3. RETORNAR URL DE DOWNLOAD (downloadMovie)
  // Em vez de baixar os bytes direto na RAM, é mais seguro retornar a URL para o Flutter fazer o download/streaming
  final downloadUrl = '${baseUrl}downloadMovie/?id=$movieId';
  return downloadUrl;
}

```
