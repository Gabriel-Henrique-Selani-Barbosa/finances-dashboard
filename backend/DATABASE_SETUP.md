# 🗄️ Configuração do Banco de Dados

## 📋 Pré-requisitos

1. **PostgreSQL** instalado e rodando
2. **Node.js** e **npm** instalados

## 🚀 Configuração Inicial

### 1. Criar Banco de Dados

```sql
CREATE DATABASE finance_dashboard;
```

### 2. Configurar Variáveis de Ambiente

Crie um arquivo `.env` na pasta `backend/` com:

```env
# Database
DATABASE_URL="postgresql://postgres:password@localhost:5432/finance_dashboard?schema=public"

# JWT
JWT_SECRET="your-super-secret-jwt-key-change-in-production"

# Server
PORT=3000
NODE_ENV=development
```

**⚠️ IMPORTANTE:** Substitua `password` pela senha do seu PostgreSQL.

### 3. Gerar Cliente Prisma

```bash
npm run db:generate
```

### 4. Sincronizar Schema com Banco

```bash
npm run db:push
```

## 🔧 Comandos Úteis

| Comando | Descrição |
|---------|-----------|
| `npm run db:generate` | Gera o cliente Prisma |
| `npm run db:push` | Sincroniza schema com banco |
| `npm run db:migrate` | Cria e aplica migrações |
| `npm run db:studio` | Abre Prisma Studio |
| `npm run db:reset` | Reseta banco e aplica migrações |

## 📊 Prisma Studio

Para visualizar e editar dados:

```bash
npm run db:studio
```

Acesse: http://localhost:5555

## 🔍 Verificar Conexão

Para testar se tudo está funcionando:

```bash
npm run dev
```

O servidor deve iniciar sem erros de conexão com o banco.

## 🚨 Troubleshooting

### Erro de Conexão
- Verifique se o PostgreSQL está rodando
- Confirme as credenciais no DATABASE_URL
- Teste a conexão: `psql -h localhost -U postgres -d finance_dashboard`

### Erro de Schema
- Execute: `npm run db:generate`
- Depois: `npm run db:push`

### Erro de Migração
- Execute: `npm run db:reset` (⚠️ apaga todos os dados) 