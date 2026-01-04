# Documentação do VektorIF

## Descrição do Projeto

VektorIF é uma aplicação desenvolvida em Flutter para o gerenciamento e visualização de mapas internos de instituições, setores e colaboradores. O aplicativo permite que usuários naveguem por mapas de instituições, visualizem detalhes de setores e encontrem colaboradores. Além disso, oferece funcionalidades de gerenciamento para cadastrar novas instituições, setores, colaboradores e mapas, utilizando o Firebase como backend.

## Funcionalidades Principais

*   **Autenticação:**
    *   Login de usuários.
    *   Cadastro de novas contas (incluindo cadastro de Instituição).
*   **Seleção de Instituição:** Permite ao usuário escolher entre diferentes instituições cadastradas.
*   **Visualização de Mapa (Home Map):** Exibe o mapa da instituição selecionada e permite interação.
*   **Gerenciamento:** Painel administrativo para acessar as funcionalidades de cadastro e listagem.
*   **Gestão de Setores:**
    *   Cadastro de novos setores com nome, categoria, descrição, e-mail e telefone.
    *   Listagem de setores cadastrados.
*   **Gestão de Colaboradores:**
    *   Cadastro de colaboradores com nome, e-mail, telefone, setor vinculado e status de chefia.
    *   Listagem de colaboradores.
*   **Gestão de Mapas:**
    *   Cadastro de informações de mapas.
    *   Upload de imagens de mapas.
    *   Edição de mapas (Map Editor) para posicionamento de setores.
*   **Integração com Firebase:**
    *   Armazenamento de dados no Cloud Firestore.
    *   Armazenamento de imagens no Firebase Storage.
    *   Autenticação via Firebase Auth.

## Estrutura do Projeto

A estrutura de diretórios do projeto segue o padrão Flutter, organizada da seguinte forma:

*   `lib/`: Contém o código fonte da aplicação.
    *   `core/`: Componentes centrais e reutilizáveis.
        *   `themes/`: Definições de tema (cores, estilos).
        *   `widgets/`: Widgets compartilhados.
    *   `models/`: Modelos de dados e repositórios.
        *   `data/`: Repositórios de dados.
        *   `*_model.dart`: Definições das classes de modelo (Institution, Sector, Collaborator).
    *   `providers/`: Gerenciamento de estado da aplicação (AuthProvider, SectorProvider, CollaboratorProvider).
    *   `screens/`: Telas da aplicação, organizadas por funcionalidade.
        *   `primary/`: Telas iniciais e de seleção (SelectInstitution).
        *   `home/`: Tela principal do mapa (HomeMap).
        *   `menagement/`: Tela de gerenciamento.
        *   `sectors/`: Telas relacionadas a setores (cadastro).
        *   `collaborators/`: Telas relacionadas a colaboradores (cadastro).
        *   `lists/`: Telas de listagem (setores, colaboradores).
        *   `map/`: Telas relacionadas a mapas (cadastro, upload, editor).
        *   `register/`: Tela de cadastro de usuário/instituição.
        *   `loginscreen/`: Tela de login.
    *   `main.dart`: Ponto de entrada da aplicação, configuração do Firebase, Providers e rotas.

## Modelos de Dados

Os principais modelos de dados utilizados na aplicação são:

*   **InstitutionModel:** Representa uma instituição.
    *   `id`: Identificador único.
    *   `name`: Nome da instituição.
    *   `address`: Endereço da instituição.
    *   `photoUrl`: URL da foto da instituição.
*   **SectorModel:** Representa um setor dentro de uma instituição.
    *   `id`: Identificador único.
    *   `name`: Nome do setor.
    *   `category`: Categoria do setor.
    *   `description`: Descrição do setor.
    *   `email`: E-mail de contato do setor.
    *   `phone`: Telefone de contato do setor.
    *   `mapX` / `mapY`: Coordenadas no mapa.
*   **CollaboratorModel:** Representa um colaborador.
    *   `id`: Identificador único.
    *   `name`: Nome do colaborador.
    *   `email`: E-mail do colaborador.
    *   `phone`: Telefone do colaborador.
    *   `sectorId` / `sectorName`: Setor vinculado.
    *   `isBoss`: Indica se é chefe do setor.
    *   `photoUrl`: URL da foto do colaborador.

## Gerenciamento de Estado

O projeto utiliza o pacote `provider` para o gerenciamento de estado. Os principais providers são:

*   `AuthProvider`: Gerencia o estado de autenticação do usuário.
*   `SectorProvider`: Gerencia os dados e operações relacionados a setores.
*   `CollaboratorProvider`: Gerencia os dados e operações relacionados a colaboradores.

## Backend

O backend da aplicação é suportado pelo **Firebase**:

*   **Firebase Auth:** Utilizado para autenticação de usuários.
*   **Cloud Firestore:** Banco de dados NoSQL para armazenar informações de instituições, setores, colaboradores e mapas.
*   **Firebase Storage:** Armazenamento de arquivos, como imagens de instituições, mapas e colaboradores.

## Telas e Navegação

A navegação no aplicativo é gerenciada através de rotas nomeadas definidas em `lib/main.dart`:

| Rota | Tela | Descrição |
| :--- | :--- | :--- |
| `/` | `EnterApp` | Tela inicial de entrada. |
| `/select-instituition` | `SelectInstitutionScreen` | Tela para seleção da instituição desejada. |
| `/home-map` | `HomeMap` | Tela principal exibindo o mapa. |
| `/management` | `ManagementScreen` | Painel de controle para acesso às funções administrativas. |
| `/sectors-register` | `SectorRegisterScreen` | Formulário para cadastro de novos setores. |
| `/sectors-list` | `ListDetailsSectors` | Lista de setores cadastrados. |
| `/collaborators-register` | `CollaboratorsRegister` | Formulário para cadastro de novos colaboradores. |
| `/collaborators-list` | `ListDetailsColaborators` | Lista de colaboradores cadastrados. |
| `/map-register` | `MapRegister` | Tela para registro de informações de mapas. |
| `/upload-map` | `UploadMapScreen` | Tela para upload de imagem do mapa. |
| `/map-editor` | `MapEditor` | Editor de mapas. |
| `/register` | `RegisterScreen` | Tela de cadastro de novo usuário/instituição. |
| `/login` | `LoginScreen` | Tela de login. |

## Como Executar

Para executar o projeto, você precisará do Flutter instalado e configurado, além das configurações do Firebase.

1.  Clone o repositório.
2.  Navegue até a pasta do projeto.
3.  Instale as dependências:
    ```bash
    flutter pub get
    ```
4.  **Configuração do Firebase:**
    *   O projeto depende do arquivo `firebase_options.dart` (gerado pelo `flutterfire configure`) e do arquivo `firebase.json`. Certifique-se de ter acesso ao projeto Firebase correspondente ou configure um novo projeto Firebase para o aplicativo.
5.  Execute o aplicativo:
    ```bash
    flutter run
    ```
