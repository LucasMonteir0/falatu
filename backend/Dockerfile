FROM node:18

WORKDIR /usr/src/api

COPY package*.json ./

RUN npm install --quiet --no-optional --no-fund --loglevel=error

COPY . .

RUN npx prisma generate

RUN npm run build

EXPOSE 3333 80 81

CMD ["npm", "run", "start:prod"]
