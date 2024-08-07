# OsConectLocal App

Este projeto contém os arquivos necessários para executar o OsConectLocal App, que serve como uma ponte entre um WebSocket e mensagens OSC.

## Requisitos do Sistema

- iOS 14.0 ou superior
- macOS 11.0 ou superior
- Xcode 12.0 ou superior

## Estrutura do Projeto

```
OsConectLocal/
├── Sources/
│   └── OsConectLocalApp/   # Pasta contendo os arquivos Swift do pacote
│       ├── ContentView.swift
│       ├── OsConectLocal.swift
│       └── OsConectLocalApp.swift
├── Tests/
│   └── OsConectLocalAppTests/ # Pasta contendo os arquivos de teste
│       └── OsConectLocalAppTests.swift
├── Package.swift           # Configuração do pacote Swift
├── README.md               # Este arquivo
└── codemagic.yaml          # Configuração do Codemagic CI/CD
```

## Configuração do Projeto

Este projeto é uma aplicação SwiftUI que utiliza o Swift Package Manager para gerenciamento de dependências. Siga estas etapas para configurar e executar o projeto:

1. Certifique-se de ter o Xcode 12.0 ou superior instalado em seu Mac.
2. Clone este repositório para sua máquina local.
3. Abra o arquivo `Package.swift` no Xcode.
4. Aguarde o Xcode resolver as dependências do pacote.
5. Selecione o esquema de destino apropriado (iOS ou macOS).
6. Execute o projeto (Command + R).

## Executando o Projeto

### Para iOS:

1. Selecione um simulador iOS ou um dispositivo iOS conectado.
2. Execute o projeto no Xcode (Command + R).

### Para macOS:

1. Selecione "My Mac" como o destino de execução.
2. Execute o projeto no Xcode (Command + R).

## Construindo com Codemagic

Este projeto está configurado para ser construído usando Codemagic CI/CD. O arquivo `codemagic.yaml` na raiz do projeto contém a configuração necessária para o processo de build.

Para usar o Codemagic:

1. Faça login na sua conta Codemagic (https://codemagic.io/).
2. Adicione este projeto ao Codemagic.
3. O Codemagic detectará automaticamente o arquivo `codemagic.yaml` e usará a configuração nele definida.
4. Inicie uma nova build no Codemagic.

Se você encontrar problemas durante o processo de build no Codemagic, verifique se:

- O arquivo `codemagic.yaml` está corretamente configurado.
- O arquivo `Package.swift` está presente na raiz do projeto e corretamente configurado.
- Todas as dependências do projeto estão corretamente listadas no `Package.swift`.

## Conexão com o Servidor WebSocket

O aplicativo se conecta a um servidor WebSocket para receber mensagens que são convertidas em OSC. O servidor WebSocket está localizado em "wss://websocket-luciano15.replit.app".

## Arquivos principais

1. `Sources/OsConectLocalApp/OsConectLocalApp.swift`: Arquivo principal SwiftUI que define a estrutura da aplicação.
2. `Sources/OsConectLocalApp/ContentView.swift`: Define a interface do usuário principal do aplicativo.
3. `Sources/OsConectLocalApp/OsConectLocal.swift`: Contém a lógica específica do OsConectLocal, incluindo a conexão WebSocket e o envio de mensagens OSC.
4. `Package.swift`: Define a configuração do pacote Swift para o projeto.

## Observações

- O aplicativo cria uma conexão WebSocket com "wss://websocket-luciano15.replit.app".
- As mensagens recebidas pelo WebSocket são convertidas em mensagens OSC e enviadas para o endereço IP local (127.0.0.1) na porta 8000.
- O aplicativo exibe o status da conexão e a última mensagem recebida.
- Os botões "Connect" e "Disconnect" permitem controlar a conexão WebSocket.

Se você encontrar problemas durante a compilação ou execução do projeto, verifique se todas as dependências estão instaladas corretamente e se o ambiente de desenvolvimento está configurado adequadamente para SwiftUI e Network Framework.

Se você tiver alguma dúvida ou precisar de ajuda, consulte a documentação do SwiftUI, Network Framework, Codemagic ou entre em contato com o desenvolvedor.
