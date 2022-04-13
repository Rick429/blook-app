package com.salesianostriana.blook.services.impl;

import com.salesianostriana.blook.config.StorageProperties;
import com.salesianostriana.blook.errors.exceptions.FileNotFoundException;
import com.salesianostriana.blook.errors.exceptions.StorageException;
import com.salesianostriana.blook.services.StorageService;
import com.salesianostriana.blook.utils.MediaTypeUrlResource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.util.FileSystemUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.annotation.PostConstruct;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.stream.Stream;

@Service
public class FileSystemStorageService implements StorageService {

    private final Path rootLocation;

    @Autowired
    public FileSystemStorageService(StorageProperties properties) {
        this.rootLocation = Paths.get(properties.getLocation());
    }


    @PostConstruct
    @Override
    public void init() {
        try {
            Files.createDirectories(rootLocation);
        } catch (IOException e) {
            throw new StorageException("No se pudo inicializar la ubicación de almacenamiento", e);
        }
    }

    @Override
    public String store(MultipartFile file) {

        try {
            return store(file.getBytes(), file.getOriginalFilename(), file.getContentType());
        } catch (IOException ex) {
            throw new StorageException("Error en el almacenamiento del fichero: " + file.getOriginalFilename(), ex);
        }

    }

    @Override
    public String store(byte[] file, String filename, String contentType) {

        String newFilename = StringUtils.cleanPath(filename);

        if (file.length == 0)
            throw new StorageException("El fichero subido está vacío");

        newFilename = calculateNewFilename(newFilename);

        try (InputStream inputStream = new ByteArrayInputStream(file)) {

            Files.copy(inputStream, rootLocation.resolve(newFilename),
                    StandardCopyOption.REPLACE_EXISTING);

        } catch(IOException ex) {
            throw new StorageException("Error en el almacenamiento del fichero: " + newFilename, ex);

        }

        return newFilename;
    }

    private String calculateNewFilename(String filename) {
        String newFilename = filename;
        while(Files.exists(rootLocation.resolve(newFilename))) {
            String extension = StringUtils.getFilenameExtension(newFilename);
            String name = newFilename.replace("."+extension,"");

            String suffix = Long.toString(System.currentTimeMillis());
            suffix = suffix.substring(suffix.length()-6);

            newFilename = name + "_" + suffix + "." + extension;

        }

        return newFilename;
    }

    @Override
    public Stream<Path> loadAll() {
        try {
            return Files.walk(this.rootLocation, 1)
                    .filter(path -> !path.equals(this.rootLocation))
                    .map(this.rootLocation::relativize);
        }
        catch (IOException e) {
            throw new StorageException("Error al leer los ficheros almacenados", e);
        }
    }

    @Override
    public Path load(String filename) {
        return rootLocation.resolve(filename);
    }

    @Override
    public Resource loadAsResource(String filename) {

        try {
            Path file = load(filename);
            MediaTypeUrlResource resource = new MediaTypeUrlResource(file.toUri());
            if (resource.exists() || resource.isReadable()) {
                return resource;
            }
            else {
                throw new FileNotFoundException(
                        "No se pudo leer el fichero: " + filename);
            }
        }
        catch (MalformedURLException e) {
            throw new FileNotFoundException("No se pudo leer el fichero: " + filename, e);
        }
    }

    @Override
    public void deleteFile(String uri) {
        String name = uri.split("/")[4];
        try {
            Path file = load(name);
            Files.delete(file);
        } catch (IOException e) {
            throw new StorageException("No se pudo eliminar el fichero: " + name, e);
        }
    }

    @Override
    public void deleteAll() {
        FileSystemUtils.deleteRecursively(rootLocation.toFile());
    }

    @Override
    public String completeUri(String filename) {
        return ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/download/")
                .path(filename)
                .toUriString();
    }
}