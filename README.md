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
├── codemagic.yaml          # Configuração do Codemagic CI/CD
└── exportOptions.plist     # Opções de exportação para TestFlight
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

## Distribuição via TestFlight

Para distribuir o app via TestFlight usando Codemagic, siga estas etapas:

1. Certifique-se de ter uma conta de desenvolvedor Apple e acesso ao App Store Connect.

2. No App Store Connect:
   - Crie um novo app com o bundle ID "com.lucianotheforce.OsConectLocalApp".
   - Obtenha as credenciais necessárias para a API do App Store Connect (chave privada, key ID e issuer ID).

3. No Codemagic:
   - Vá para as configurações do seu app.
   - Na seção "Environment variables", adicione as seguintes variáveis secretas:
     - APP_STORE_CONNECT_PRIVATE_KEY
     - APP_STORE_CONNECT_KEY_IDENTIFIER
     - APP_STORE_CONNECT_ISSUER_ID
   - Preencha com os valores obtidos no App Store Connect.

4. No arquivo `exportOptions.plist`:
   - Substitua "YOUR_TEAM_ID" pelo seu Apple Developer Team ID.

5. Faça commit das alterações e push para o repositório GitHub.

6. No Codemagic, inicie uma nova build.

7. Após a conclusão bem-sucedida da build, o app será enviado automaticamente para o TestFlight.

8. No App Store Connect, você poderá gerenciar a distribuição do TestFlight e convidar testadores.

## Observações

- O aplicativo cria uma conexão WebSocket com "wss://websocket-luciano15.replit.app".
- As mensagens recebidas pelo WebSocket são convertidas em mensagens OSC e enviadas para o endereço IP local (127.0.0.1) na porta 8000.
- O aplicativo exibe o status da conexão e a última mensagem recebida.
- Os botões "Connect" e "Disconnect" permitem controlar a conexão WebSocket.

Se você encontrar problemas durante a compilação, execução do projeto ou distribuição via TestFlight, verifique se todas as dependências estão instaladas corretamente e se o ambiente de desenvolvimento está configurado adequadamente para SwiftUI e Network Framework.

Se você tiver alguma dúvida ou precisar de ajuda, consulte a documentação do SwiftUI, Network Framework, Codemagic, TestFlight ou entre em contato com o desenvolvedor.
