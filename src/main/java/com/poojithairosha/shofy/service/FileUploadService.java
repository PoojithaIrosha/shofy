package com.poojithairosha.shofy.service;

import jakarta.servlet.ServletContext;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.Context;
import org.glassfish.jersey.media.multipart.ContentDisposition;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Comparator;

public class FileUploadService {

    @Context
    private ServletContext context;

    public static final String UPLOAD_DIR_NAME = "/upload";

    public FileItem upload(String directoryName, InputStream fileInputStream, ContentDisposition fileMetaData, String fileName) {
        Path UPLOAD_PATH = Paths.get(context.getRealPath(UPLOAD_DIR_NAME + "/" + directoryName));

        if (!Files.exists(UPLOAD_PATH)) {
            try {
                System.out.println("Uploading directory not found, creating directory: '"+UPLOAD_PATH+"'");
                Files.createDirectories(UPLOAD_PATH);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        try {
            int read = 0;
            byte[] bytes = new byte[1024];

            OutputStream out = new FileOutputStream(new File(UPLOAD_PATH + "/" + fileName));
            while ((read = fileInputStream.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }
            out.flush();
            out.close();
        } catch (IOException e) {
            throw new WebApplicationException("Error while uploading file. Please try again !!");
        }

        String app_url = String.format("http://%s:%s%s", "localhost", 8080, context.getContextPath());

        String url = context.getContextPath() + UPLOAD_DIR_NAME + "/" + directoryName + "/" + fileName;
        String fullUrl = app_url + UPLOAD_DIR_NAME + "/" + directoryName + "/" + fileName;

        return new FileItem(fileName, fileMetaData.getFileName(), UPLOAD_DIR_NAME + "/" + directoryName + "/" + fileName, url, fullUrl);
    }

    public boolean deleteFile(String file) {
        Path UPLOAD_PATH = Paths.get(context.getRealPath(UPLOAD_DIR_NAME));
        final boolean[] delete = new boolean[1];
        try {
            Files.walk(UPLOAD_PATH).sorted(Comparator.reverseOrder())
                    .forEach(path -> {
                        File f = path.toFile();
                        System.out.println(f.getName());

                        String[] split = file.split("/");
                        String filename = split[split.length - 1];

                        if (f.getName().equals(filename)) {
                            System.out.println("KK");
                            delete[0] = f.delete();
                        }
                    });
        } catch (IOException e) {
            e.printStackTrace();
        }
        return delete[0];
    }

    public static class FileItem {
        private String fileName;
        private String fileNameOriginal;
        private String path;
        private String url;
        private String fullUrl;

        public FileItem(String fileName, String fileNameOriginal, String path, String url, String fullUrl) {
            this.fileName = fileName;
            this.fileNameOriginal = fileNameOriginal;
            this.path = path;
            this.url = url;
            this.fullUrl = fullUrl;
        }

        public String getFileName() {
            return fileName;
        }

        public String getFileNameOriginal() {
            return fileNameOriginal;
        }

        public String getPath() {
            return path;
        }

        public String getUrl() {
            return url;
        }

        public String getFullUrl() {
            return fullUrl;
        }
    }
}
