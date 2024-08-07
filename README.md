# OsConectLocal App

Este projeto contém os arquivos necessários para executar o OsConectLocal App no seu iPad, que serve como uma ponte entre um WebSocket e mensagens MIDI para uso com o AUM.

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
│       ├── Info.plist
│       └── OsConectLocalAppTests.m
├── ios/                    # Pasta contendo arquivos específicos do iOS
├── App.js                  # Arquivo principal do React Native
├── package.json            # Configuração e dependências do npm
├── Package.swift           # Configuração do pacote Swift
├── codemagic.yaml          # Configuração do Codemagic CI/CD
└── README.md               # Este arquivo
```

## Configuração do Projeto

Este projeto é uma aplicação React Native com componentes Swift adicionais. Siga estas etapas para configurar e executar o projeto:

1. Certifique-se de ter o Node.js e o npm instalados em seu sistema.
2. Instale o React Native CLI globalmente:
   ```
   npm install -g react-native-cli
   ```
3. Na pasta raiz do projeto, instale as dependências:
   ```
   npm install
   ```

## Executando o Projeto

### Para iOS:

1. Certifique-se de ter o Xcode instalado em seu Mac.
2. Navegue até a pasta do projeto e execute:
   ```
   npx react-native run-ios
   ```

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
- Todas as dependências do projeto estão corretamente listadas no `package.json`.
- O arquivo `ios/Podfile` existe e está corretamente configurado.

## Conexão com o Servidor WebSocket

O aplicativo se conecta a um servidor WebSocket para receber mensagens que são convertidas em MIDI. O servidor WebSocket está localizado em "wss://websocket-luciano15.replit.app".

## Arquivos principais

1. `App.js`: Arquivo principal do React Native.
2. `Sources/OsConectLocalApp/OsConectLocalApp.swift`: Arquivo principal Swift que define a estrutura da aplicação SwiftUI.
3. `Sources/OsConectLocalApp/ContentView.swift`: Define a interface do usuário principal do aplicativo.
4. `Sources/OsConectLocalApp/OsConectLocal.swift`: Contém a lógica específica do OsConectLocal.
5. `Package.swift`: Define a configuração do pacote Swift para o projeto.
6. `Tests/OsConectLocalAppTests/OsConectLocalAppTests.m`: Contém os testes unitários para o aplicativo.

## Observações

- O aplicativo cria um MIDI output virtual chamado "OsConectLocal MIDI".
- As mensagens recebidas pelo WebSocket são convertidas em mensagens MIDI:
  - Mensagens de faders são convertidas em Control Change (CC) messages.
  - Mensagens de notas são convertidas em Note On messages.
- Os valores dos faders são mapeados de 0-100 para o range MIDI de 0-127.
- Os números dos faders (1-8) são usados diretamente como números de CC.

Se você encontrar problemas durante a compilação ou execução do projeto, verifique se todas as dependências estão instaladas corretamente e se o ambiente de desenvolvimento está configurado adequadamente para React Native e Swift.

Se você tiver alguma dúvida ou precisar de ajuda, consulte a documentação do React Native, Swift, Codemagic ou entre em contato com o desenvolvedor.
