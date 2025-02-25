FROM node:18

WORKDIR /usr/src/api

COPY package*.json ./

RUN npm install --quiet --no-optional --no-fund --loglevel=error

RUN npx prisma generate

COPY . .


RUN npm run build

EXPOSE 3333 80 81

CMD ["npm", "run", "start:prod"]
