FROM node:4.3.2

RUN useradd --user-group --create-home --shell /bin/false app &&\
  npm install --global npm@3.7.5

ENV HOME=/home/app

#COPY package.json npm-shrinkwrap.json $HOME/chest/
COPY package.json $HOME/chest/
RUN chown -R app:app $HOME/*

USER app
WORKDIR $HOME/chest
RUN npm install

CMD ["node", "index.js"]
