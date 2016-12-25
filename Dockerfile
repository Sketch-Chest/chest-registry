FROM node:argon

# create app directory
WORKDIR /app

# install deps (for caching)
COPY package.json client/package.json /app/
RUN npm install

# copy entire source code
COPY . /app

CMD ["npm", "start"]
