// import * as Minio from "minio";

// const bucket = new Minio.Client({
//   endPoint: "play.min.io",
//   accessKey: process.env.S3_ACCESS_KEY_ID,
//   secretKey: process.env.S3_SECRET_ACCESS_KEY,
//   port: 9000,
//   useSSL: true,
// });

// export default async function sendFileToBucket({
//   file,
//   bucketName,
//   fileName,
// }: {
//   file: Express.Multer.File;
//   bucketName: string;
//   fileName: string;
// }) {
//   const metaData = { "Content-Type": file.mimetype };
//   const exists = await bucket.bucketExists(bucketName);

//   if (!exists) {
//     await bucket.makeBucket(bucketName, "us-east-1");
//   }

//   await bucket.putObject(
//     bucketName,
//     fileName,
//     file.buffer,
//     file.size,
//     metaData,
//   );
//   return "play.min.io:9000" + `/${bucketName}/${fileName}`;
// }
