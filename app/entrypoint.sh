FROM medusajs/medusa:latest

WORKDIR /app

# Copy only necessary files (avoid copying node_modules)
COPY . .

# Entrypoint for DB migrations/health checks
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["medusa", "start"]