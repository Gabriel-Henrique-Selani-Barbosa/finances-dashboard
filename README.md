# Dashboard de Finanças

Um dashboard completo para gerenciamento de finanças pessoais desenvolvido com Vue.js no frontend e Node.js no backend.

## Estrutura do Projeto

```
finance-dashboard/
├── frontend/                 # Aplicação Vue.js
│   ├── src/
│   │   ├── components/       # Componentes reutilizáveis
│   │   ├── views/           # Páginas/rotas da aplicação
│   │   ├── assets/          # Imagens, CSS, etc.
│   │   ├── router/          # Configuração de rotas
│   │   ├── store/           # Gerenciamento de estado (Vuex)
│   │   ├── utils/           # Funções utilitárias
│   │   └── services/        # Serviços de API
│   └── public/              # Arquivos públicos
│
└── backend/                  # API Node.js
    ├── src/
    │   ├── controllers/     # Controladores das rotas
    │   ├── models/          # Modelos de dados
    │   ├── routes/          # Definição das rotas
    │   ├── middleware/      # Middlewares personalizados
    │   ├── config/          # Configurações do projeto
    │   ├── utils/           # Funções utilitárias
    │   └── services/        # Lógica de negócio
    └── uploads/             # Arquivos enviados pelos usuários
```

## Tecnologias Utilizadas

### Frontend
- Vue.js 3
- Vue Router
- Vuex (ou Pinia)
- Axios para requisições HTTP
- CSS/SCSS para estilização

### Backend
- Node.js
- Express.js
- MongoDB (ou PostgreSQL)
- JWT para autenticação
- Multer para upload de arquivos

## Funcionalidades Planejadas

- [ ] Autenticação de usuários
- [ ] Dashboard com resumo financeiro
- [ ] Cadastro de receitas e despesas
- [ ] Categorização de transações
- [ ] Relatórios e gráficos
- [ ] Metas financeiras
- [ ] Exportação de dados

## Como Executar

### Backend
```bash
cd backend
npm install
npm run dev
```

### Frontend
```bash
cd frontend
npm install
npm run serve
```

## Status do Projeto

�� Em desenvolvimento 