# 🚀 Setup Completo - Dashboard de Finanças

## 📋 Pré-requisitos

### Instalar antes de começar:
```bash
# Node.js (versão 18+)
# Baixar de: https://nodejs.org/

# Git
# Baixar de: https://git-scm.com/

# VS Code (recomendado)
# Baixar de: https://code.visualstudio.com/

# Extensões VS Code recomendadas:
# - Vue Language Features (Volar)
# - TypeScript Vue Plugin (Volar)
# - Prisma
# - ESLint
# - Prettier
# - Auto Rename Tag
# - Bracket Pair Colorizer
```

## 🛠️ Comandos de Setup

### 1. Verificar versões instaladas:
```bash
node --version    # Deve ser 18+
npm --version     # Deve ser 9+
git --version
```

### 2. Configurar o Backend:
```bash
cd backend

# Inicializar projeto
npm init -y

# Instalar dependências principais
npm install express cors dotenv bcryptjs jsonwebtoken multer

# Instalar dependências de desenvolvimento
npm install --save-dev typescript @types/node @types/express @types/cors @types/bcryptjs @types/jsonwebtoken @types/multer nodemon ts-node

# Instalar Prisma
npm install prisma @prisma/client

# Inicializar TypeScript
npx tsc --init

# Inicializar Prisma
npx prisma init

# Instalar PostgreSQL (Windows)
# Baixar de: https://www.postgresql.org/download/windows/
# Ou usar Docker:
# docker run --name postgres-finance -e POSTGRES_PASSWORD=finance123 -e POSTGRES_DB=finance_db -p 5432:5432 -d postgres
```

### 3. Configurar o Frontend:
```bash
cd ../frontend

# Criar projeto Vue 3 com TypeScript
npm create vue@latest . -- --typescript --router --pinia --eslint --prettier

# Instalar dependências adicionais
npm install axios @vueuse/core chart.js vue-chartjs

# Instalar dependências de desenvolvimento
npm install --save-dev @types/node
```

### 4. Configurar scripts no package.json do Backend:
```json
{
  "scripts": {
    "dev": "nodemon src/server.ts",
    "build": "tsc",
    "start": "node dist/server.js",
    "db:generate": "prisma generate",
    "db:push": "prisma db push",
    "db:migrate": "prisma migrate dev",
    "db:studio": "prisma studio"
  }
}
```

### 5. Configurar scripts no package.json do Frontend:
```json
{
  "scripts": {
    "dev": "vite",
    "build": "vue-tsc && vite build",
    "preview": "vite preview",
    "lint": "eslint . --ext .vue,.js,.jsx,.cjs,.mjs,.ts,.tsx,.cts,.mts --fix --ignore-path .gitignore"
  }
}
```

## 🗄️ Configuração do Banco de Dados

### 1. Configurar Prisma (backend/prisma/schema.prisma):
```prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model User {
  id           Int           @id @default(autoincrement())
  email        String        @unique
  name         String
  passwordHash String
  createdAt    DateTime      @default(now())
  updatedAt    DateTime      @updatedAt
  transactions Transaction[]
  categories   Category[]
  goals        Goal[]
}

model Category {
  id          Int           @id @default(autoincrement())
  name        String
  type        TransactionType
  color       String        @default("#3B82F6")
  userId      Int
  user        User          @relation(fields: [userId], references: [id])
  transactions Transaction[]
  createdAt   DateTime      @default(now())
}

model Transaction {
  id          Int             @id @default(autoincrement())
  amount      Decimal
  description String
  date        DateTime
  type        TransactionType
  userId      Int
  categoryId  Int?
  user        User            @relation(fields: [userId], references: [id])
  category    Category?       @relation(fields: [categoryId], references: [id])
  createdAt   DateTime        @default(now())
}

model Goal {
  id            Int      @id @default(autoincrement())
  name          String
  targetAmount  Decimal
  currentAmount Decimal  @default(0)
  deadline      DateTime?
  userId        Int
  user          User     @relation(fields: [userId], references: [id])
  createdAt     DateTime @default(now())
}

enum TransactionType {
  INCOME
  EXPENSE
}
```

### 2. Configurar .env (backend/.env):
```env
DATABASE_URL="postgresql://username:password@localhost:5432/finance_db"
JWT_SECRET="seu_jwt_secret_super_seguro_aqui"
PORT=3000
```

## 🗺️ Roadmap de Desenvolvimento

### 📅 **Fase 1: Fundação (Semana 1)**
#### Backend:
- [ ] Configurar estrutura básica do Express
- [ ] Configurar Prisma e conectar ao PostgreSQL
- [ ] Criar middleware de autenticação JWT
- [ ] Implementar validação de dados (Zod ou Joi)
- [ ] Configurar CORS e middlewares de segurança

#### Frontend:
- [ ] Configurar estrutura básica do Vue 3
- [ ] Configurar Vue Router
- [ ] Configurar Pinia para gerenciamento de estado
- [ ] Criar layout base da aplicação
- [ ] Configurar Axios para requisições HTTP

### 📅 **Fase 2: Autenticação (Semana 2)**
#### Backend:
- [ ] Criar modelo User no Prisma
- [ ] Implementar rota de registro (/auth/register)
- [ ] Implementar rota de login (/auth/login)
- [ ] Implementar middleware de autenticação
- [ ] Criar rota de perfil do usuário

#### Frontend:
- [ ] Criar página de login
- [ ] Criar página de registro
- [ ] Implementar store de autenticação (Pinia)
- [ ] Criar guard de rota para páginas protegidas
- [ ] Implementar interceptor para adicionar token nas requisições

### 📅 **Fase 3: Categorias (Semana 3)**
#### Backend:
- [ ] Criar modelo Category no Prisma
- [ ] Implementar CRUD de categorias
- [ ] Validar que usuário só acessa suas categorias
- [ ] Implementar cores padrão para categorias

#### Frontend:
- [ ] Criar página de gerenciamento de categorias
- [ ] Implementar formulário de criação/edição
- [ ] Criar componente de seleção de categoria
- [ ] Implementar store de categorias

### 📅 **Fase 4: Transações (Semana 4)**
#### Backend:
- [ ] Criar modelo Transaction no Prisma
- [ ] Implementar CRUD de transações
- [ ] Implementar filtros por data, categoria, tipo
- [ ] Criar endpoints para relatórios básicos

#### Frontend:
- [ ] Criar página de transações
- [ ] Implementar formulário de nova transação
- [ ] Criar lista de transações com filtros
- [ ] Implementar store de transações

### 📅 **Fase 5: Dashboard (Semana 5)**
#### Backend:
- [ ] Criar endpoints para dados do dashboard
- [ ] Implementar cálculos de resumo financeiro
- [ ] Criar endpoints para gráficos

#### Frontend:
- [ ] Criar página principal do dashboard
- [ ] Implementar cards de resumo (saldo, receitas, despesas)
- [ ] Criar gráficos com Chart.js
- [ ] Implementar filtros por período

### 📅 **Fase 6: Metas e Relatórios (Semana 6)**
#### Backend:
- [ ] Criar modelo Goal no Prisma
- [ ] Implementar CRUD de metas
- [ ] Criar endpoints para relatórios avançados
- [ ] Implementar exportação de dados

#### Frontend:
- [ ] Criar página de metas financeiras
- [ ] Implementar progresso visual das metas
- [ ] Criar página de relatórios
- [ ] Implementar exportação de dados

### 📅 **Fase 7: Polimento (Semana 7)**
#### Backend:
- [ ] Implementar upload de arquivos (comprovantes)
- [ ] Otimizar consultas do banco
- [ ] Implementar cache
- [ ] Adicionar logs e monitoramento

#### Frontend:
- [ ] Melhorar UX/UI
- [ ] Implementar responsividade
- [ ] Adicionar animações
- [ ] Implementar PWA (Progressive Web App)

### 📅 **Fase 8: Deploy (Semana 8)**
- [ ] Configurar ambiente de produção
- [ ] Deploy do backend (Railway, Heroku, Vercel)
- [ ] Deploy do frontend (Vercel, Netlify)
- [ ] Configurar domínio personalizado
- [ ] Implementar CI/CD

## 🎯 **Ordem de Prioridade para Começar:**

1. **Configurar ambiente** (PostgreSQL, Node.js, Vue)
2. **Implementar autenticação** (login/registro)
3. **Criar layout base** da aplicação
4. **Implementar categorias** (base para transações)
5. **Implementar transações** (funcionalidade core)
6. **Criar dashboard** com resumos
7. **Adicionar relatórios** e gráficos
8. **Implementar metas** e funcionalidades extras

## 🔧 **Comandos para Executar na Ordem:**

```bash
# 1. Configurar backend
cd backend
npm init -y
npm install express cors dotenv bcryptjs jsonwebtoken multer
npm install --save-dev typescript @types/node @types/express @types/cors @types/bcryptjs @types/jsonwebtoken @types/multer nodemon ts-node
npm install prisma @prisma/client
npx tsc --init
npx prisma init

# 2. Configurar frontend
cd ../frontend
npm create vue@latest . -- --typescript --router --pinia --eslint --prettier
npm install axios @vueuse/core chart.js vue-chartjs

# 3. Configurar banco
cd ../backend
# Editar prisma/schema.prisma
# Editar .env com DATABASE_URL
npx prisma generate
npx prisma db push

# 4. Iniciar desenvolvimento
# Terminal 1 (backend):
cd backend && npm run dev

# Terminal 2 (frontend):
cd frontend && npm run dev
```

## 📚 **Recursos Úteis:**

- **Vue 3 Docs:** https://vuejs.org/
- **Pinia Docs:** https://pinia.vuejs.org/
- **Prisma Docs:** https://www.prisma.io/docs/
- **Express Docs:** https://expressjs.com/
- **Chart.js:** https://www.chartjs.org/ 