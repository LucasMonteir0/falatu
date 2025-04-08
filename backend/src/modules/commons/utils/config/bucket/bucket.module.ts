import { Global, Module } from "@nestjs/common";
import { BucketService } from "./bucket.service";

@Global()
@Module({
  providers: [BucketService],
  exports: [BucketService],
})
export class BucketModule {}