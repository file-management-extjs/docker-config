# Frontend Dockerfile

FROM node:14

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Copy all frontend source code
COPY . .

# Expose frontend port
EXPOSE 3000

# Start the frontend server (or replace with your build/start commands)
CMD ["npm", "start"]
