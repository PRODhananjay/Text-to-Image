# Base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy entire project
COPY . .

# Install backend dependencies
WORKDIR /app/server
RUN npm install

# Install frontend dependencies & build React app
WORKDIR /app/client
RUN npm install --legacy-peer-deps
RUN npm run build

# Go back to server
WORKDIR /app/server

# Install 'serve' to serve frontend build
RUN npm install -g serve

# Expose ports
EXPOSE 5000
EXPOSE 3000

# Start both frontend + backend
CMD ["sh", "-c", "node server.js & serve -s ../client/build -l 3000"]