FROM python:3.11-slim

WORKDIR /app

# Install uv for package management
RUN pip install --no-cache-dir uv

# Install the mcp-server-qdrant package
# COPY ./src/mcp_server_qdrant /app/mcp-server-qdrant
# RUN uv pip install --system --no-cache-dir /app/mcp-server-qdrant
RUN uv pip install --system --no-cache-dir mcp-server-qdrant

# Expose the default port for SSE transport
EXPOSE 8000

# Set environment variables with defaults that can be overridden at runtime
ENV QDRANT_URL="http://qdrant:6333"
ENV COLLECTION_NAME="test_collection"
ENV EMBEDDING_MODEL="sentence-transformers/all-MiniLM-L6-v2"
ENV FASTMCP_HOST=0.0.0.0
ENV FASTMCP_PORT=8000

# Run the server with SSE transport
CMD uvx mcp-server-qdrant --transport sse