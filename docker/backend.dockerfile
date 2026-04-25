# Backend Dockerfile

FROM node:18-alpine

# Create app directory
WORKDIR /app

# Install system dependencies including Redis client and PDF Studio tools.
RUN ALPINE_VERSION="$(cut -d. -f1,2 /etc/alpine-release)" && \
    if ! grep -q "v${ALPINE_VERSION}/community" /etc/apk/repositories; then \
        echo "https://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VERSION}/community" >> /etc/apk/repositories; \
    fi && \
    apk add --no-cache \
	    p7zip \
	    tar \
	    gzip \
	    python3 \
	    py3-pip \
	    make \
	    g++ \
	    git \
	    openssh-client \
	    redis \
	    clamav \
	    clamav-daemon \
	    qpdf \
	    poppler-utils \
	    ghostscript \
	    libreoffice-common \
	    libreoffice-writer \
	    libreoffice-calc \
	    libreoffice-impress \
	    libreoffice-draw \
	    libreoffice-lang-en_us \
	    pandoc-cli \
	    font-noto \
	    font-noto-cjk \
	    ttf-dejavu && \
    apk add --no-cache \
        --repository=https://dl-cdn.alpinelinux.org/alpine/v3.22/community \
        pdfcpu

RUN pip3 install --no-cache-dir --break-system-packages --no-deps \
    PyMuPDF==1.27.2.2 \
    python-docx==1.2.0 \
    fonttools==4.62.1 \
    fire==0.7.1 \
    termcolor==3.3.0 \
    pdf2docx==0.5.12

RUN apk add --no-cache \
    py3-numpy \
    py3-opencv \
    py3-lxml \
    py3-typing-extensions


# Update virus definitions
RUN freshclam

# Install app dependencies
COPY package*.json ./
RUN npm install

# Copy app source code
COPY ./src ./src
COPY ./scripts ./scripts

# Expose backend port
EXPOSE 5000

# Run backend server
CMD ["npm", "start"]
