FROM medusajs/medusa:latest

WORKDIR /app

# Install any additional dependencies if needed
# RUN npm install --production

COPY . .

# Use the entrypoint script
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["medusa", "start"]