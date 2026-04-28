FROM node:18-alpine

WORKDIR /app

RUN ALPINE_VERSION="$(cut -d. -f1,2 /etc/alpine-release)" && \
    if ! grep -q "v${ALPINE_VERSION}/community" /etc/apk/repositories; then \
        echo "https://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VERSION}/community" >> /etc/apk/repositories; \
    fi && \
    apk add --no-cache \
        python3 \
        py3-pip \
        make \
        g++ \
        qpdf \
        poppler-utils \
        tesseract-ocr \
        tesseract-ocr-data-eng \
        tesseract-ocr-data-ara \
        ghostscript \
        libreoffice-common \
        libreoffice-writer \
        libreoffice-calc \
        libreoffice-impress \
        libreoffice-draw \
        libreoffice-lang-en_us \
        pandoc-cli \
        ttf-dejavu

COPY package*.json ./
RUN npm install --omit=dev

COPY ./src ./src

EXPOSE 4200

CMD ["npm", "start"]
