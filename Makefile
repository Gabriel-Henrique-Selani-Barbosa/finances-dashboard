# 🚀 Makefile - Dashboard de Finanças
# Comandos para facilitar o desenvolvimento (Multi-OS)

# Variáveis
BACKEND_DIR = backend
FRONTEND_DIR = frontend
NODE_ENV = development

# Detecção do Sistema Operacional
ifeq ($(OS),Windows_NT)
    # Windows
    OS_NAME = Windows
    SHELL = cmd
    RM = rmdir /s /q
    MKDIR = mkdir
    CD = cd
    START_CMD = start cmd /k
    START_TERM = start cmd /k
    PATH_SEP = \\
    NODE_MODULES = node_modules
    DIST_DIR = dist
else
    # Mac/Linux
    OS_NAME = Unix
    SHELL = /bin/bash
    RM = rm -rf
    MKDIR = mkdir -p
    CD = cd
    START_CMD = gnome-terminal --tab -- bash -c
    START_TERM = open -a Terminal
    PATH_SEP = /
    NODE_MODULES = node_modules
    DIST_DIR = dist
endif

# Cores para output (funciona em Windows e Unix)
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[0;34m
RED = \033[0;31m
NC = \033[0m # No Color

# Comandos principais
.PHONY: help install setup dev build clean test lint format db-setup db-reset

# Comando padrão - mostra ajuda
help:
	@echo "$(BLUE)🚀 Dashboard de Finanças - Comandos Disponíveis$(NC)"
	@echo "$(YELLOW)Sistema detectado: $(OS_NAME)$(NC)"
	@echo ""
	@echo "$(GREEN)📦 Setup e Instalação:$(NC)"
	@echo "  make install     - Instala dependências do backend e frontend"
	@echo "  make setup       - Configuração inicial completa do projeto"
	@echo "  make db-setup    - Configura banco de dados e Prisma"
	@echo ""
	@echo "$(GREEN)🛠️ Desenvolvimento:$(NC)"
	@echo "  make dev         - Inicia backend e frontend em desenvolvimento"
	@echo "  make dev-back    - Inicia apenas o backend"
	@echo "  make dev-front   - Inicia apenas o frontend"
	@echo ""
	@echo "$(GREEN)🏗️ Build e Deploy:$(NC)"
	@echo "  make build       - Build do backend e frontend"
	@echo "  make build-back  - Build apenas do backend"
	@echo "  make build-front - Build apenas do frontend"
	@echo ""
	@echo "$(GREEN)🧹 Limpeza:$(NC)"
	@echo "  make clean       - Remove node_modules e arquivos de build"
	@echo "  make clean-back  - Limpa apenas o backend"
	@echo "  make clean-front - Limpa apenas o frontend"
	@echo ""
	@echo "$(GREEN)🔍 Qualidade de Código:$(NC)"
	@echo "  make lint        - Executa linting no backend e frontend"
	@echo "  make format      - Formata código com Prettier"
	@echo "  make test        - Executa testes"
	@echo ""
	@echo "$(GREEN)🗄️ Banco de Dados:$(NC)"
	@echo "  make db-setup    - Configura banco e executa migrations"
	@echo "  make db-reset    - Reseta banco de dados"
	@echo "  make db-studio   - Abre Prisma Studio"
	@echo "  make db-push     - Push do schema para o banco"
	@echo ""

# Instalação de dependências
install:
	@echo "$(BLUE)📦 Instalando dependências...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@$(CD) $(BACKEND_DIR) && npm install
	@echo "$(YELLOW)Frontend...$(NC)"
	@$(CD) $(FRONTEND_DIR) && npm install
	@echo "$(GREEN)✅ Dependências instaladas com sucesso!$(NC)"

# Setup inicial completo
setup: install db-setup
	@echo "$(GREEN)🎉 Setup completo finalizado!$(NC)"
	@echo "$(BLUE)Execute 'make dev' para iniciar o desenvolvimento$(NC)"

# Desenvolvimento - Detecta OS automaticamente
dev:
	@echo "$(BLUE)🚀 Iniciando desenvolvimento...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@echo "$(YELLOW)Backend rodando em http://localhost:3000$(NC)"
	@echo "$(YELLOW)Frontend rodando em http://localhost:5173$(NC)"
	@echo "$(GREEN)Use Ctrl+C para parar$(NC)"
ifeq ($(OS),Windows_NT)
	@$(START_CMD) "cd $(BACKEND_DIR) && npm run dev"
	@$(START_CMD) "cd $(FRONTEND_DIR) && npm run dev"
else
	@$(START_CMD) "cd $(BACKEND_DIR) && npm run dev; exec bash" &
	@$(START_CMD) "cd $(FRONTEND_DIR) && npm run dev; exec bash" &
endif

# Desenvolvimento apenas backend
dev-back:
	@echo "$(BLUE)🚀 Iniciando backend...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@$(CD) $(BACKEND_DIR) && npm run dev

# Desenvolvimento apenas frontend
dev-front:
	@echo "$(BLUE)🚀 Iniciando frontend...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@$(CD) $(FRONTEND_DIR) && npm run dev

# Build
build:
	@echo "$(BLUE)🏗️ Fazendo build...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@echo "$(YELLOW)Backend...$(NC)"
	@$(CD) $(BACKEND_DIR) && npm run build
	@echo "$(YELLOW)Frontend...$(NC)"
	@$(CD) $(FRONTEND_DIR) && npm run build
	@echo "$(GREEN)✅ Build concluído!$(NC)"

# Build apenas backend
build-back:
	@echo "$(BLUE)🏗️ Fazendo build do backend...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@$(CD) $(BACKEND_DIR) && npm run build

# Build apenas frontend
build-front:
	@echo "$(BLUE)🏗️ Fazendo build do frontend...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@$(CD) $(FRONTEND_DIR) && npm run build

# Limpeza - Detecta OS automaticamente
clean:
	@echo "$(BLUE)🧹 Limpando projeto...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@echo "$(YELLOW)Backend...$(NC)"
ifeq ($(OS),Windows_NT)
	@$(CD) $(BACKEND_DIR) && $(RM) $(NODE_MODULES) 2>nul || echo "node_modules não encontrado"
	@$(CD) $(BACKEND_DIR) && $(RM) $(DIST_DIR) 2>nul || echo "dist não encontrado"
else
	@$(CD) $(BACKEND_DIR) && $(RM) $(NODE_MODULES) 2>/dev/null || echo "node_modules não encontrado"
	@$(CD) $(BACKEND_DIR) && $(RM) $(DIST_DIR) 2>/dev/null || echo "dist não encontrado"
endif
	@echo "$(YELLOW)Frontend...$(NC)"
ifeq ($(OS),Windows_NT)
	@$(CD) $(FRONTEND_DIR) && $(RM) $(NODE_MODULES) 2>nul || echo "node_modules não encontrado"
	@$(CD) $(FRONTEND_DIR) && $(RM) $(DIST_DIR) 2>nul || echo "dist não encontrado"
else
	@$(CD) $(FRONTEND_DIR) && $(RM) $(NODE_MODULES) 2>/dev/null || echo "node_modules não encontrado"
	@$(CD) $(FRONTEND_DIR) && $(RM) $(DIST_DIR) 2>/dev/null || echo "dist não encontrado"
endif
	@echo "$(GREEN)✅ Limpeza concluída!$(NC)"

# Limpeza apenas backend
clean-back:
	@echo "$(BLUE)🧹 Limpando backend...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
ifeq ($(OS),Windows_NT)
	@$(CD) $(BACKEND_DIR) && $(RM) $(NODE_MODULES) 2>nul || echo "node_modules não encontrado"
	@$(CD) $(BACKEND_DIR) && $(RM) $(DIST_DIR) 2>nul || echo "dist não encontrado"
else
	@$(CD) $(BACKEND_DIR) && $(RM) $(NODE_MODULES) 2>/dev/null || echo "node_modules não encontrado"
	@$(CD) $(BACKEND_DIR) && $(RM) $(DIST_DIR) 2>/dev/null || echo "dist não encontrado"
endif

# Limpeza apenas frontend
clean-front:
	@echo "$(BLUE)🧹 Limpando frontend...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
ifeq ($(OS),Windows_NT)
	@$(CD) $(FRONTEND_DIR) && $(RM) $(NODE_MODULES) 2>nul || echo "node_modules não encontrado"
	@$(CD) $(FRONTEND_DIR) && $(RM) $(DIST_DIR) 2>nul || echo "dist não encontrado"
else
	@$(CD) $(FRONTEND_DIR) && $(RM) $(NODE_MODULES) 2>/dev/null || echo "node_modules não encontrado"
	@$(CD) $(FRONTEND_DIR) && $(RM) $(DIST_DIR) 2>/dev/null || echo "dist não encontrado"
endif

# Linting
lint:
	@echo "$(BLUE)🔍 Executando linting...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@echo "$(YELLOW)Backend...$(NC)"
ifeq ($(OS),Windows_NT)
	@$(CD) $(BACKEND_DIR) && npm run lint 2>nul || echo "Lint não configurado no backend"
else
	@$(CD) $(BACKEND_DIR) && npm run lint 2>/dev/null || echo "Lint não configurado no backend"
endif
	@echo "$(YELLOW)Frontend...$(NC)"
	@$(CD) $(FRONTEND_DIR) && npm run lint

# Formatação
format:
	@echo "$(BLUE)🎨 Formatando código...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@echo "$(YELLOW)Backend...$(NC)"
ifeq ($(OS),Windows_NT)
	@$(CD) $(BACKEND_DIR) && npx prettier --write . 2>nul || echo "Prettier não configurado no backend"
else
	@$(CD) $(BACKEND_DIR) && npx prettier --write . 2>/dev/null || echo "Prettier não configurado no backend"
endif
	@echo "$(YELLOW)Frontend...$(NC)"
ifeq ($(OS),Windows_NT)
	@$(CD) $(FRONTEND_DIR) && npm run format 2>nul || npx prettier --write .
else
	@$(CD) $(FRONTEND_DIR) && npm run format 2>/dev/null || npx prettier --write .
endif

# Testes
test:
	@echo "$(BLUE)🧪 Executando testes...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@echo "$(YELLOW)Backend...$(NC)"
ifeq ($(OS),Windows_NT)
	@$(CD) $(BACKEND_DIR) && npm test 2>nul || echo "Testes não configurados no backend"
else
	@$(CD) $(BACKEND_DIR) && npm test 2>/dev/null || echo "Testes não configurados no backend"
endif
	@echo "$(YELLOW)Frontend...$(NC)"
ifeq ($(OS),Windows_NT)
	@$(CD) $(FRONTEND_DIR) && npm test 2>nul || echo "Testes não configurados no frontend"
else
	@$(CD) $(FRONTEND_DIR) && npm test 2>/dev/null || echo "Testes não configurados no frontend"
endif

# Configuração do banco de dados
db-setup:
	@echo "$(BLUE)🗄️ Configurando banco de dados...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@$(CD) $(BACKEND_DIR) && npx prisma generate
	@$(CD) $(BACKEND_DIR) && npx prisma db push
	@echo "$(GREEN)✅ Banco de dados configurado!$(NC)"

# Reset do banco de dados
db-reset:
	@echo "$(RED)⚠️ ATENÇÃO: Isso vai apagar todos os dados!$(NC)"
	@echo "$(YELLOW)Deseja continuar? (y/N)$(NC)"
ifeq ($(OS),Windows_NT)
	@set /p confirm="" && if "!confirm!"=="y" ( \
		$(CD) $(BACKEND_DIR) && npx prisma migrate reset --force && \
		echo "$(GREEN)✅ Banco de dados resetado!$(NC)" \
	) else ( \
		echo "$(YELLOW)Operação cancelada$(NC)" \
	)
else
	@read -p "" confirm && if [ "$$confirm" = "y" ]; then \
		$(CD) $(BACKEND_DIR) && npx prisma migrate reset --force; \
		echo "$(GREEN)✅ Banco de dados resetado!$(NC)"; \
	else \
		echo "$(YELLOW)Operação cancelada$(NC)"; \
	fi
endif

# Prisma Studio
db-studio:
	@echo "$(BLUE)🗄️ Abrindo Prisma Studio...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@$(CD) $(BACKEND_DIR) && npx prisma studio

# Push do schema
db-push:
	@echo "$(BLUE)🗄️ Fazendo push do schema...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@$(CD) $(BACKEND_DIR) && npx prisma db push

# Migrations
db-migrate:
	@echo "$(BLUE)🗄️ Executando migrations...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@$(CD) $(BACKEND_DIR) && npx prisma migrate dev

# Verificar status
status:
	@echo "$(BLUE)📊 Status do projeto:$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@echo "$(YELLOW)Node.js:$(NC)"
	@node --version
	@echo "$(YELLOW)npm:$(NC)"
	@npm --version
	@echo "$(YELLOW)Git:$(NC)"
	@git --version
	@echo "$(YELLOW)Backend:$(NC)"
ifeq ($(OS),Windows_NT)
	@$(CD) $(BACKEND_DIR) && npm list --depth=0 2>nul || echo "Backend não configurado"
else
	@$(CD) $(BACKEND_DIR) && npm list --depth=0 2>/dev/null || echo "Backend não configurado"
endif
	@echo "$(YELLOW)Frontend:$(NC)"
ifeq ($(OS),Windows_NT)
	@$(CD) $(FRONTEND_DIR) && npm list --depth=0 2>nul || echo "Frontend não configurado"
else
	@$(CD) $(FRONTEND_DIR) && npm list --depth=0 2>/dev/null || echo "Frontend não configurado"
endif

# Comandos de utilidade
logs:
	@echo "$(BLUE)📋 Logs do projeto:$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@echo "$(YELLOW)Backend logs:$(NC)"
ifeq ($(OS),Windows_NT)
	@$(CD) $(BACKEND_DIR) && type logs\*.log 2>nul || echo "Nenhum log encontrado"
else
	@$(CD) $(BACKEND_DIR) && cat logs/*.log 2>/dev/null || echo "Nenhum log encontrado"
endif
	@echo "$(YELLOW)Frontend logs:$(NC)"
ifeq ($(OS),Windows_NT)
	@$(CD) $(FRONTEND_DIR) && type logs\*.log 2>nul || echo "Nenhum log encontrado"
else
	@$(CD) $(FRONTEND_DIR) && cat logs/*.log 2>/dev/null || echo "Nenhum log encontrado"
endif

# Backup do banco (se configurado)
backup:
	@echo "$(BLUE)💾 Fazendo backup do banco...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
ifeq ($(OS),Windows_NT)
	@$(CD) $(BACKEND_DIR) && npx prisma db pull --print > backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%.prisma
else
	@$(CD) $(BACKEND_DIR) && npx prisma db pull --print > backup_$(shell date +%Y%m%d_%H%M%S).prisma
endif
	@echo "$(GREEN)✅ Backup criado!$(NC)"

# Restaurar backup
restore:
	@echo "$(BLUE)🔄 Restaurando backup...$(NC)"
	@echo "$(YELLOW)Sistema: $(OS_NAME)$(NC)"
	@echo "$(YELLOW)Arquivos de backup disponíveis:$(NC)"
ifeq ($(OS),Windows_NT)
	@dir backup_*.prisma 2>nul || echo "Nenhum backup encontrado"
	@echo "$(YELLOW)Digite o nome do arquivo de backup:$(NC)"
	@set /p backup_file="" && \
		$(CD) $(BACKEND_DIR) && copy ..\$$backup_file prisma\schema.prisma && \
		npx prisma db push && \
		echo "$(GREEN)✅ Backup restaurado!$(NC)"
else
	@ls backup_*.prisma 2>/dev/null || echo "Nenhum backup encontrado"
	@echo "$(YELLOW)Digite o nome do arquivo de backup:$(NC)"
	@read -p "" backup_file && \
		$(CD) $(BACKEND_DIR) && cp ../$$backup_file prisma/schema.prisma && \
		npx prisma db push && \
		echo "$(GREEN)✅ Backup restaurado!$(NC)"
endif

# Comando para mostrar informações do sistema
info:
	@echo "$(BLUE)🖥️ Informações do Sistema:$(NC)"
	@echo "$(YELLOW)Sistema Operacional: $(OS_NAME)$(NC)"
ifeq ($(OS),Windows_NT)
	@echo "$(YELLOW)Versão do Windows:$(NC)"
	@ver
else
	@echo "$(YELLOW)Distribuição:$(NC)"
	@uname -a
endif
	@echo "$(YELLOW)Shell: $(SHELL)$(NC)"
	@echo "$(YELLOW)Comando de remoção: $(RM)$(NC)"
	@echo "$(YELLOW)Comando de criação: $(MKDIR)$(NC)" 