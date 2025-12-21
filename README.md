# Documentação do VektorIF

## Descrição do Projeto

VektorIF é uma aplicação desenvolvida em Flutter para o gerenciamento e visualização de mapas internos de instituições, setores e colaboradores. O aplicativo permite que usuários naveguem por mapas de instituições, visualizem detalhes de setores e encontrem colaboradores. Além disso, oferece funcionalidades de gerenciamento para cadastrar novas instituições, setores, colaboradores e mapas.

## Funcionalidades Principais

*   **Seleção de Instituição:** Permite ao usuário escolher entre diferentes instituições cadastradas.
*   **Visualização de Mapa (Home Map):** Exibe o mapa da instituição selecionada.
*   **Gerenciamento:** Painel administrativo para acessar as funcionalidades de cadastro e listagem.
*   **Gestão de Setores:**
    *   Cadastro de novos setores com nome, telefone e descrição.
    *   Listagem de setores com detalhes.
*   **Gestão de Colaboradores:**
    *   Cadastro de colaboradores com nome, e-mail e setor vinculado.
    *   Listagem de colaboradores.
*   **Gestão de Mapas:**
    *   Cadastro de informações de mapas.
    *   Upload de imagens de mapas.
    *   Edição de mapas (Map Editor).

## Estrutura do Projeto

A estrutura de diretórios do projeto segue o padrão Flutter, organizada da seguinte forma:

*   `lib/`: Contém o código fonte da aplicação.
    *   `core/`: Componentes centrais e reutilizáveis.
        *   `themes/`: Definições de tema (cores, estilos).
        *   `widgets/`: Widgets compartilhados.
    *   `models/`: Modelos de dados e repositórios.
        *   `data/`: Repositórios de dados (atualmente contendo dados mockados).
        *   `*_model.dart`: Definições das classes de modelo (Institution, Sector, Employee).
    *   `screens/`: Telas da aplicação, organizadas por funcionalidade.
        *   `primary/`: Telas iniciais e de seleção.
        *   `home/`: Tela principal do mapa.
        *   `menagement/`: Tela de gerenciamento.
        *   `sectors/`: Telas relacionadas a setores (cadastro).
        *   `collaborators/`: Telas relacionadas a colaboradores (cadastro).
        *   `lists/`: Telas de listagem (setores, colaboradores).
        *   `map/`: Telas relacionadas a mapas (cadastro, upload, editor).
    *   `main.dart`: Ponto de entrada da aplicação e configuração de rotas.

## Modelos de Dados

Os principais modelos de dados utilizados na aplicação são:

*   **InstitutionModel:** Representa uma instituição.
    *   `name`: Nome da instituição.
    *   `address`: Endereço da instituição.
*   **SectorModel:** Representa um setor dentro de uma instituição.
    *   `name`: Nome do setor.
    *   `phone`: Telefone de contato.
    *   `description`: Descrição do setor.
*   **EmployeeModel:** Representa um colaborador.
    *   `name`: Nome do colaborador.
    *   `email`: E-mail do colaborador.
    *   `sector`: Setor ao qual o colaborador pertence.

## Telas e Navegação

A navegação no aplicativo é gerenciada através de rotas nomeadas definidas em `lib/main.dart`:

| Rota | Tela | Descrição |
| :--- | :--- | :--- |
| `/` | `EnterApp` | Tela inicial de entrada. |
| `/select-instituition` | `SelectInstitutionScreen` | Tela para seleção da instituição desejada. |
| `/home-map` | `HomeMap` | Tela principal exibindo o mapa. |
| `/management` | `ManagementScreen` | Painel de controle para acesso às funções administrativas. |
| `/sectors-register` | `SectorRegisterScreen` | Formulário para cadastro de novos setores. |
| `/sectors-list` | `ListDetailsSectors` | Lista de setores cadastrados com detalhes. |
| `/collaborators-register` | `CollaboratorsRegister` | Formulário para cadastro de novos colaboradores. |
| `/collaborators-list` | `ListDetailsColaborators` | Lista de colaboradores cadastrados. |
| `/map-register` | `MapRegister` | Tela para registro de informações de mapas. |
| `/upload-map` | `UploadMapScreen` | Tela para upload de imagem do mapa. |
| `/map-editor` | `MapEditor` | Editor de mapas. |

## Como Executar

Para executar o projeto, certifique-se de ter o Flutter instalado e configurado em sua máquina.

1.  Clone o repositório.
2.  Navegue até a pasta do projeto.
3.  Instale as dependências:
    ```bash
    flutter pub get
    ```
4.  Execute o aplicativo:
    ```bash
    flutter run
    ```
