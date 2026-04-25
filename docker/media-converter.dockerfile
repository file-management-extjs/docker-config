FROM node:18-alpine

WORKDIR /app

RUN apk add --no-cache \
    ffmpeg \
    font-noto \
    font-noto-cjk \
    libva \
    libva-intel-driver \
    libva-utils \
    mesa-dri-gallium \
    mesa-va-gallium \
    ttf-dejavu

COPY package*.json ./
RUN npm install

COPY ./src ./src

EXPOSE 4100

CMD ["npm", "start"]
