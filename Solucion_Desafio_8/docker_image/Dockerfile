FROM node:18

RUN mkdir -p /home/app/volume

WORKDIR /home/app

COPY . .

RUN npm install

EXPOSE 3000

VOLUME /home/app/volume

CMD ["node", "index.js"]