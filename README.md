# Flutter Application

Este é um aplicativo Flutter que utiliza diversas bibliotecas populares para gerenciar navegação, estado, requisições HTTP, segurança de armazenamento, validação de formulários, máscaras de campos de texto, entre outros. Abaixo estão listados os pacotes utilizados e suas funções no projeto.

## Pacotes Utilizados

### 1. [flutter_modular](https://pub.dev/packages/flutter_modular) - ^6.3.4
O `flutter_modular` é usado para gerenciamento de rotas e injeção de dependências no projeto. Ele organiza a navegação e a estruturação do projeto com módulos, facilitando a escalabilidade.

### 2. [flutter_bloc](https://pub.dev/packages/flutter_bloc) - ^8.1.6
O `flutter_bloc` é utilizado para gerenciar o estado do aplicativo de forma reativa e organizada, separando lógica de negócios da interface do usuário. Ele permite uma comunicação eficaz entre eventos e estados dentro do app.

### 3. [dio](https://pub.dev/packages/dio) - ^5.7.0
`dio` é uma biblioteca poderosa de requisições HTTP para Dart e Flutter. Ela permite realizar chamadas HTTP de maneira fácil e segura, com suporte a interceptores, que são usados para lidar com tokens de autenticação, entre outros.

### 4. [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) - ^9.2.2
Este pacote permite armazenar dados de forma segura no dispositivo, como tokens de sessão. As informações são criptografadas e mantidas protegidas.

### 5. [equatable](https://pub.dev/packages/equatable) - ^2.0.5
O `equatable` é utilizado para facilitar a comparação entre objetos, tornando-os comparáveis por valor, ao invés de referência. Isso é muito útil em estados gerenciados por blocos e em entidades.

### 6. [dartz](https://pub.dev/packages/dartz) - ^0.10.1
O `dartz` adiciona suporte para programação funcional, como tipos `Either` (usado para retornar resultados ou falhas de operações) e `Option`. É amplamente utilizado para tratar erros de forma segura e sem exceções.

### 7. [formz](https://pub.dev/packages/formz) - ^0.7.0
`formz` é uma biblioteca de validação de formulários usada para validar inputs no aplicativo. Ela oferece uma forma declarativa e limpa de validar campos com diversos estados, como campos obrigatórios ou com formatos inválidos.

### 8. [brasil_fields](https://pub.dev/packages/brasil_fields) - ^1.15.0
O `brasil_fields` fornece uma série de máscaras e formatos comumente usados no Brasil, como CPF, CNPJ, datas, CEP e muito mais. Ele é utilizado para formatar e validar inputs no padrão brasileiro.

### 9. [flutter_lints](https://pub.dev/packages/flutter_lints) - ^4.0.0
Este pacote fornece regras de lint para manter o código consistente e de alta qualidade. Ele ajuda a seguir as melhores práticas no desenvolvimento com Flutter.

### 10. [bloc_test](https://pub.dev/packages/bloc_test) - ^9.1.7
`bloc_test` é usado para escrever testes unitários e de integração para blocos. Ele facilita a simulação de eventos e verificação de estados em blocos e cubits.

### 11. [mocktail](https://pub.dev/packages/mocktail) - ^1.0.4
O `mocktail` é uma biblioteca para criação de mocks em testes unitários. Ele é usado para simular comportamentos em dependências e verificar interações durante a execução de testes.

## Instalar o Json Rest Server

Este projeto utiliza o `json_rest_server` para simular um backend local e fornecer endpoints para o aplicativo se comunicar. Siga os passos abaixo para configurar o servidor local:

### Crie a pasta do backend

1. **Crie uma pasta chamada `backend/`:**
   - No diretório raiz do projeto, crie uma nova pasta chamada `backend/`.
   
2. **Entre na pasta `backend/`:**
   - Navegue até a pasta criada com o comando: 
     ```bash
     cd backend/
     ```

### Instalação

1. **Instale o Dart:**
   - Se você já tem o Flutter instalado, você não precisa instalar o Dart separadamente.
   - Caso contrário, siga as instruções no [site oficial do Dart](https://dart.dev/get-dart) para instalar o Dart no seu sistema.

2. **Ative o Json Rest Server:**
   - Para ativar o `json_rest_server`, execute o seguinte comando:
     ```bash
     dart pub global activate json_rest_server
     ```

### Configurações

Após a instalação, o servidor local precisa de algumas configurações, que ficam no arquivo `config.yaml`. Aqui estão as principais configurações:

- **name**: Nome do servidor.
- **port**: Porta de acesso para o servidor.
- **host**: Defina como `0.0.0.0` para o servidor responder tanto por IP quanto por `localhost`.
- **database**: Nome do arquivo do banco de dados.
- **idType**: Pode ser `uuid` ou `int` (para IDs autoincrementais ou UUIDs).

### Comandos

O comando padrão para o projeto é `json_rest_server`. Entretanto, você também pode usar `jsonRestServer` ou apenas `jrs` para facilitar a digitação.

- **Atualizando o Json Rest Server:**
   - Para atualizar o `json_rest_server`, execute:
     ```bash
     json_rest_server upgrade
     ```

### Criando o Projeto

Os comandos a seguir criam toda a configuração necessária para rodar o servidor:

1. **Crie um projeto de servidor:**
   - Em uma pasta vazia, execute:
     ```bash
     json_rest_server create
     ```

2. **Criar o projeto em uma nova pasta:**
   - Caso você queira que o `json_rest_server` crie uma nova pasta, execute:
     ```bash
     json_rest_server create ./nome_pasta
     ```

### Iniciando o Servidor

1. **Rodando o servidor:**
   - Após criar o projeto, entre na pasta onde você executou o comando `create` e inicie o servidor com o seguinte comando:
     ```bash
     json_rest_server run
     ```

Agora que o servidor está configurado, siga as instruções na próxima seção para instalar as dependências e executar o projeto Flutter.

## Como Executar o Projeto

1. **Instalar as dependências:**
   - Execute o comando abaixo para instalar todas as dependências do projeto:
     ```bash
     flutter pub get
     ```

2. **Rodar o aplicativo:**
   - Para rodar o aplicativo em um emulador ou dispositivo físico:
     ```bash
     flutter run
     ```

3. **Rodar os testes:**
   - Para rodar os testes unitários do projeto:
     ```bash
     flutter test
     ```

## Estrutura do Projeto

- **features/**: Contém os módulos do aplicativo divididos por funcionalidades (ex: Auth, Home, etc.).
- **core/**: Contém as funcionalidades compartilhadas, como serviços, widgets e modelos que podem ser reutilizados.
- **data/**: Repositórios, fontes de dados (datasources) e modelos usados para lidar com a comunicação com APIs.
- **domain/**: Contém as entidades e casos de uso (use cases) que representam as regras de negócio do aplicativo.
- **presentation/**: Contém as telas (pages), cubits e widgets que gerenciam a interface com o usuário.

## Contribuindo

Se você deseja contribuir para o projeto, siga estas etapas:

1. Faça um fork do repositório.
2. Crie uma branch com a sua feature (`git checkout -b feature/nome-da-feature​⬤
