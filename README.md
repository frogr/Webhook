# Webhook Rails App

A simple Rails API application that receives webhooks and logs them.

## Quick Start with Docker

### For Development

```bash
# Build and start the containers
docker-compose up

# In another terminal, create the database
docker-compose exec web rails db:create
docker-compose exec web rails db:migrate
```

The app will be available at http://localhost:3000

### For Production (Fly.io/AWS)

Build the production image:
```bash
docker build -t webhook .
```

Run locally for testing:
```bash
docker run -p 80:80 -e RAILS_MASTER_KEY=$(cat config/master.key) webhook
```

## Testing the Webhook

Send a test webhook:
```bash
curl -X POST http://localhost:3000/webhooks \
  -H "Content-Type: application/json" \
  -d '{"event": "test", "data": {"message": "Hello World"}}'
```

Check the logs to see the webhook data:
```bash
docker-compose logs web
```

## Deployment

The production Dockerfile is optimized for deployment to:
- Fly.io: Use `fly launch` and follow the prompts
- AWS ECS: Push the image to ECR and create a task definition
- Any container platform that supports Docker images