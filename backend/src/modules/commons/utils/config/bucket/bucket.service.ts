import { initializeApp } from "firebase/app";
import { Injectable } from "@nestjs/common";
import { firebaseConfig } from "../firebase.config";
import { getDownloadURL, getStorage, ref, uploadBytes } from "firebase/storage";
import { dotEnvConfig } from "../dotenv.config";

dotEnvConfig();

export type BucketOptions = {
  path: string;
  fileName: string;
  extension: string;
  file: Express.Multer.File;
  contentType?: string;
};

@Injectable()
export class BucketService {
  private readonly storage;
  constructor() {
    const firebase = initializeApp(firebaseConfig);
    this.storage = getStorage(firebase);
  }

  async uploadFile(options: BucketOptions): Promise<string> {
    const extParts = options.extension.split(".");
    const extension = extParts[extParts.length - 1];
    const fileName = `${options.fileName}.${extension}`;

    const storageRef = ref(this.storage, `${options.path}/${fileName}`);
    const metadata = {
      contentType: options.contentType ?? options.file.mimetype,
    };

    const result = await uploadBytes(storageRef, options.file.buffer, metadata);
    return await getDownloadURL(result.ref);
  }

  async getUrl(path: string): Promise<string> {
    try {
      const storageRef = ref(this.storage, path);
      return await getDownloadURL(storageRef);
    } catch (e) {
      console.error(e);
      throw e;
    }
  }
}
