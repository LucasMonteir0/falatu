<img src="img.png" height="450"/>
<img src="img_1.png" height="450"/>
<img src="img_2.png" height="450"/>

## 🇧🇷 FalaTu Chat

**FalaTu Chat** é uma aplicação fullstack desenvolvida para o meu portfólio. Ela permite a criação e autenticação de
usuários, criação de chats com novos contatos e envio de mensagens em diferentes formatos: **texto, áudio, arquivo,
imagem e vídeo**.

---

### 🛠️ Backend

O backend foi desenvolvido com **Node.js v20.10.0** utilizando o ecossistema **NestJS**, com banco de dados **PostgreSQL
**, **Firebase Storage** para armazenamento de arquivos e **WebSockets** nativos do NestJS para comunicação em tempo
real.

#### 🔧 Tecnologias:

- NestJS
- PostgreSQL
- Firebase Storage
- WebSockets (Gateway NestJS)

#### 🧱 Arquitetura do Projeto:

```
src/
|___ main.ts                        # Ponto de entrada da aplicação, onde a função main() fica.
|___ app_module.ts                  # Modulo principal da aplicação.
|___ modules/                       # Diretório responsavel por armazenar os diretórios de cada módulo.
   |___ module/                     # Modulo-Feature da aplicação.
       |___ module.module.ts        # Responsável por configurar o modulo da feature.
       |___ module.controller.ts    # Arquivo responsavel pelas rotas HTTP .
       |___ datasouces/             # Encarregado de buscar dados do banco de dados.
       |___ dtos/                   # Modelos de dados que são usados para transportar dados dentro da aplicação.
       |___ entites/                # Modelos de dados que refletem as entidades do banco de dados.
       |___ middlewares/            # Funções que podem ser executadas antes ou depois do processamento de uma solicitação.
       |___ gateways/               # Resposavel pelo WebSocket do módulo.
       |___ utils/                  # Diretório que contém arquivos utilitários, configurações e classes genéricas que são reutilizadas em todo o módulo.
           |___ config/             # Contém arquivos de configuração que controlam várias configurações da aplicação.
           |___ helpers/            # Contém classes auxiliares que ajudam a aplicação de diversas formas.
           |___ pipes/              # Contém classes que transformam e validam dados de entrada.
           |___ result/             # Contém a implementação de um padrão de envoltório de resultado para tratar de operações que podem falhar ou ter sucesso.
           |___ validators/         # Contém arquivos responsaveis por validar objetos sob determiada regra na aplicação.
```

#### 🚀 Inicializando com Docker:

1. Configure os arquivos `.env` conforme o `example.env`, removendo o prefixo `example` do nome do arquivo.
2. No terminal, execute o comando abaixo:
   ```bash
   docker-compose up --build
   ```

---

### 🎯 Frontend

O frontend foi desenvolvido com **Flutter v3.27.1**, seguindo os princípios do **SOLID** e da **Clean Architecture**. A
estrutura do projeto foi pensada para ser escalável e de fácil manutenção.

#### 📦 Principais Pacotes:

- **Flutter Modular**: Gerenciamento de rotas e injeção de dependências.
- **Bloc**: Gerenciamento de estado.
- **Shared Preferences**: Cache local.

#### 🧱 Arquitetura do Projeto:

```
lib/
|___ app.dart                  # Ponto central da aplicação Flutter, onde são feitas configurações de inicialização.
|___ main.dart                 # Ponto de entrada da aplicação, onde a função main() fica.
|___ module/                   # Modulo-Feature da aplicação.
   |___ utils/                 # Diretório que contém arquivos utilitários, configurações e classes genéricas que são reutilizadas em todo o módulo.
   |   |___ enums/             # Contém arquivos de enums para agrupar um conjunto de valores constantes.
   |   |___ erros/             # Contém classes para lidar com os diferentes tipos de erros que a aplicação pode encontrar.
   |   |___ extensions/        # Contém extensões para adicionar funcionalidades a tipos já existentes.
   |   |___ formatters/        # Contém formatadores para diversas partes da aplicação.
   |   |___ guards/            # Contém os Guards das rotas da aplicação para restringir o acesso a determinadas rotas.
   |   |___ hepers/            # Contém classes auxiliares que ajudam a aplicação de diversas formas.
   |   |___ resources/         # Contém arquivos voltados para a configuração de tema e localizations.
   |   |___ states/            # Contém a definição dos estados de UI que podem ser compartilhados entre vários widgets.
   | 
   |___ core/                  # Diretório que contém a lógica central do módulo (ou seja, as regras de negócio).
   |   |___ data/              # Contém as implementações de armazenamento de dados e redes da aplicação.
   |   |   |___ datasouces/    # Encarregado de buscar dados de uma fonte externa, como uma API.
   |   |   |___ models/        # Modelos de dados que são usados para transportar dados dentro da aplicação.
   |   |   |___ repositories/  # Implementa a lógica de busca e armazenamento de dados.
   |   |   |___ services/      # Implementa a lógica de um service externo.
   |   |   
   |   |___ domain/            # Contém a lógica de negócios central e as entidades da aplicação.
   |       |___ use_cases/     # Encarregado de orquestrar a execução das regras de negócios.
   |       |___ repositories/  # Interfaces que definem o que os repositórios de dados devem fazer.
   |       |___ entities/      # Objetos simples que representam os dados que a aplicação trabalha.
   |       |___ services/      # Interfaces que definem o que os services devem fazer.
   |
   |___ ui/                    # Diretório que contém toda a parte de UI do módulo.
       |___ blocs/             # Contém as classes responsaveis pelo gerenciamento de estado da UI.
       |___ components/        # Contém os widgets menores que são caracterizados como componentes.
       |___ pages/             # Contém os widgets de página que representam as diferentes telas da aplicação.
```

#### ▶️ Rodando o projeto:

1. Configure o arquivo `.env` conforme o `example.env`, removendo o prefixo `example`.
2. Execute o projeto com o Flutter:
    - Se houver mais de um dispositivo conectado:
      ```bash
      flutter run -d <deviceID>
      ```
    - Caso contrário:
      ```bash
      flutter run
      ```

---

## 🇺🇸 FalaTu Chat

**FalaTu Chat** is a fullstack application developed for my portfolio. It allows user registration and authentication,
creation of chats with new contacts, and sending messages in various formats: **text, audio, file, image, and video**.

---

### 🛠️ Backend

The backend is built with **Node.js v20.10.0** using the **NestJS** ecosystem, with a **PostgreSQL** database, *
*Firebase Storage** for file storage, and **NestJS WebSocket Gateway** for real-time communication.

#### 🔧 Technologies:

- NestJS
- PostgreSQL
- Firebase Storage
- WebSockets (NestJS Gateway)

#### 🧱 Project Architecture:

```
src/
|___ main.ts                         # Entry point of the application, where the main() function is located.
|___ app_module.ts                   # Main module of the application.
|___ modules/                        # Directory responsible for storing each module's folder.
    |___ module/                     # Feature module of the application.
        |___ module.module.ts        # Responsible for configuring the feature module.
        |___ module.controller.ts    # File responsible for handling HTTP routes.
        |___ datasources/            # Responsible for fetching data from the database.
        |___ dtos/                   # Data models used to transport information within the application.
        |___ entities/               # Data models that reflect the database entities.
        |___ middlewares/            # Functions that can be executed before or after processing a request.
        |___ gateways/               # Responsible for the module's WebSocket communication.
        |___ utils/                  # Directory containing utility files, configurations, and generic classes reused across the module.
            |___ config/             # Contains configuration files that manage various application settings.
            |___ helpers/            # Contains helper classes that assist the application in various ways.
            |___ pipes/              # Contains classes that transform and validate incoming data.
            |___ result/             # Contains the implementation of a result wrapper pattern to handle operations that can succeed or fail.
            |___ validators/         # Contains files responsible for validating objects based on specific rules within the application.
```

#### 🚀 Starting with Docker:

1. Configure the `.env` files according to `example.env`, and remove the `example` from the filename.
2. In the terminal, run:
   ```bash
   docker-compose up --build
   ```

---

### 🎯 Frontend

The frontend is built with **Flutter v3.27.1**, following **SOLID** principles and **Clean Architecture** for better
scalability and maintainability.

#### 📦 Main Packages:

- **Flutter Modular**: Route and dependency management.
- **Bloc**: State management.
- **Shared Preferences**: Local cache.

#### 🧱 Project Architecture:

```
lib/
|___ app.dart                   # Central point of the Flutter application where initialization configurations are made.
|___ main.dart                  # Entry point of the application, where the main() function is located.
|___ module/                    # Feature module of the application.
    |___ utils/                 # Directory containing utility files, configurations, and generic classes reused throughout the module.
    |   |___ enums/             # Contains enum files to group a set of constant values.
    |   |___ errors/            # Contains classes to handle different types of errors the application may encounter.
    |   |___ extensions/        # Contains extensions to add functionality to existing types.
    |   |___ formatters/        # Contains formatters used in different parts of the application.
    |   |___ guards/            # Contains route guards to restrict access to specific routes in the application.
    |   |___ helpers/           # Contains helper classes that assist the application in various ways.
    |   |___ resources/         # Contains files related to theme configuration and localizations.
    |   |___ states/            # Contains UI state definitions that can be shared across multiple widgets.
    |
    |___ core/                  # Directory containing the core logic of the module (i.e., business rules).
    |   |___ data/              # Contains implementations for data storage and networking.
    |   |   |___ datasources/   # Responsible for fetching data from external sources, such as APIs.
    |   |   |___ models/        # Data models used to transport data within the application.
    |   |   |___ repositories/  # Implements the logic for data retrieval and storage.
    |   |   |___ services/      # Implements logic for interacting with external services.
    |   |   
    |   |___ domain/            # Contains the core business logic and entities of the application.
    |       |___ use_cases/     # Responsible for orchestrating the execution of business rules.
    |       |___ repositories/  # Interfaces that define what the data repositories should do.
    |       |___ entities/      # Simple objects representing the data the application works with.
    |       |___ services/      # Interfaces that define what the services should do.
    |
    |___ ui/                    # Directory containing all the UI-related parts of the module.
         |___ blocs/            # Contains classes responsible for managing UI state.
         |___ components/       # Contains smaller widgets categorized as components.
         |___ pages/            # Contains page widgets that represent different screens in the application.
```

#### ▶️ Running the project:

1. Configure the `.env` file based on `example.env`, removing the `example` prefix.
2. Run the project with Flutter:
    - If multiple devices are connected:
      ```bash
      flutter run -d <deviceID>
      ```
    - Otherwise:
      ```bash
      flutter run
      ```