"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.uploadFile = uploadFile;
const multer_1 = require("multer");
const upload = (0, multer_1.default)({ storage: multer_1.default.memoryStorage() });
function uploadFile(fileName) {
    return upload.single(fileName);
}
//# sourceMappingURL=UploadFile.js.map