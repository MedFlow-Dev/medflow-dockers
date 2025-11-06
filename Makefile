.PHONY: help dciup-dev dci-api-shell dci-client-shell dcidown dci-logs dci-clean

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

dciup-dev: ## Build and start all containers
	@echo "Building and starting containers..."
	@docker-compose up -d --build 
	@echo "✅ Containers are ready!"

dci-api-shell: ## Enter the API container shell
	@echo "Entering API container..."
	@echo "Run: npm run start:dev"
	@echo ""
	docker exec -it medflow-backend sh

dci-client-shell: ## Enter the Client container shell
	@echo "Entering Client container..."
	@echo "Run: npm run dev"
	@echo ""
	docker exec -it medflow-frontend sh

dcidown: ## Stop all containers
	docker-compose down

dci-logs: ## Show logs for all containers
	docker-compose logs -f

dci-logs-api: ## Show logs for API container
	docker-compose logs -f backend

dci-logs-client: ## Show logs for Client container
	docker-compose logs -f frontend

dci-logs-db: ## Show logs for Database container
	docker-compose logs -f postgres

dci-clean: ## Stop containers and remove volumes
	docker-compose down -v
	@echo "⚠️  All data has been removed!"

dci-rebuild: ## Rebuild containers without cache
	docker-compose build --no-cache

dci-ps: ## Show running containers
	docker-compose ps

dci-restart-api: ## Restart API container
	docker-compose restart backend

dci-restart-client: ## Restart Client container
	docker-compose restart frontend

dci-db-shell: ## Enter PostgreSQL shell
	docker exec -it medflow-postgres psql -U medflow_user -d medflow_db

dci-prisma-migrate: ## Run Prisma migrations in API container
	docker exec -it medflow-backend npx prisma migrate dev --schema=./prisma/schemas/schema.prisma

dci-prisma-studio: ## Open Prisma Studio
	docker exec -it medflow-backend npx prisma studio --schema=./prisma/schemas/schema.prisma

dci-prisma-generate: ## Generate Prisma Client
	docker exec -it medflow-backend npx prisma generate --schema=./prisma/schemas/schema.prisma


# Git Commands

# Pulls the main repo and it's submodules
git-spull: ## Smart pull - update main repo and all submodules
	@echo "📥 Pulling main repository..."
	@git pull origin main
	@echo ""
	@echo "📥 Updating submodules..."
	@git submodule update --remote --merge
	@echo ""
	@echo "✅ All repositories updated!"
	@echo ""
	@git submodule status
