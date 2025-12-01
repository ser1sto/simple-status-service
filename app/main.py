import os
from fastapi import FastAPI

app = FastAPI()


@app.get("/health")
async def health():
    return {
        "status": "healthy"
        }


@app.get("/info")
async def info():
    env_value = os.getenv("APP_ENV", "default-env-value")
    return {
        "service": "hello-service", 
        "environment": env_value
        }
