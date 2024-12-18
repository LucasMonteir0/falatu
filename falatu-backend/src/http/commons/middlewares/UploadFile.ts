import multer from 'multer';

const upload = multer({ storage: multer.memoryStorage() });

export function uploadFile(fileName: string) {
  return upload.single(fileName);
}
