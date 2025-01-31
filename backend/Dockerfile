FROM node:18

WORKDIR /usr/src/api

COPY . .

RUN npm install --quiet --no-optional --no-fund --loglevel=error

RUN npm run build

EXPOSE 3333 80

CMD ["npm", "run", "start:prod"]
