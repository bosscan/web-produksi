import os
from dotenv import load_dotenv

load_dotenv(override=True)

class Config:
    SERVER_HOST = os.getenv("SERVER_HOST", "0.0.0.0")
    SERVER_PORT = int(os.getenv("SERVER_PORT", 50000))
    DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://postgres:l4ztiken@localhost:5432/erp_sakura")