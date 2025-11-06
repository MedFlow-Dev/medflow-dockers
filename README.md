# MedFlow

Medical workflow management system with NestJS backend and Next.js frontend.

## Repository Structure

This is a monorepo using Git submodules:

- `backend.medflow.com/` - NestJS API backend
- `www.medflow.com/` - Next.js frontend

## Quick Start

### First Time Setup
```bash
# Clone with submodules
git clone --recurse-submodules git@github.com:your-org/medflow.git
cd medflow

# If you already cloned without --recurse-submodules:
git submodule init
git submodule update
```

### Development Workflow
```bash
# 1. Build and start all containers
make dciup-dev

# 2. In Terminal 1 - Start backend
make dci-api-shell
npm run start:dev

# 3. In Terminal 2 - Start frontend
make dci-client-shell
npm run dev
```

### Available Commands
```bash
make help                 # Show all available commands
make dciup-dev           # Build and start containers
make dci-api-shell       # Enter backend container
make dci-client-shell    # Enter frontend container
make dcidown             # Stop all containers
make dci-logs            # Show logs
make dci-clean           # Stop and remove volumes
make dci-ps              # Show running containers
```

## URLs

- Frontend: http://localhost:3001
- Backend API: http://localhost:3000
- Database: localhost:5432

## Working with Submodules

### Update Submodules
```bash
# Update all submodules to latest
git submodule update --remote

# Update specific submodule
cd www.medflow.com
git pull origin main
cd ..
git add www.medflow.com
git commit -m "Update frontend submodule"
```

### Making Changes in Submodules
```bash
# Navigate to submodule
cd backend.medflow.com

# Make changes and commit
git checkout -b feature/my-feature
git add .
git commit -m "Add new feature"
git push origin feature/my-feature

# Go back to main repo and update reference
cd ..
git add backend.medflow.com
git commit -m "Update backend submodule to include new feature"
git push
```

## Database

PostgreSQL database runs in Docker container:
- User: `medflow_user`
- Password: `medflow_password`
- Database: `medflow_db`

## Environment Variables

See individual submodule READMEs for environment configuration.
