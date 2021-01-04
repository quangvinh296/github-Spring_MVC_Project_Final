/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.ImageEntity;
import com.mycompany.spring_mvc_project_final.repository.ImageRepository;
import java.util.List;
import java.util.Optional;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author my
 */
@Service
@Transactional
public class ImageServiceImpl {

    @Autowired
    private ImageRepository imageRepository;

    public void save(ImageEntity imageEntity) {
        imageRepository.save(imageEntity);
    }

    public void saveAll(List<ImageEntity> images) {
        imageRepository.saveAll(images);
    }

    public boolean deleteImage(int id) {
        if (imageRepository.existsById(id)) {
            imageRepository.deleteById(id);
        }
        return !imageRepository.existsById(id);
    }

    public List<ImageEntity> getImages() {
        return  (List<ImageEntity>) imageRepository.findAll();
    }
    
    public List<ImageEntity> findListPicturebyId(int id){
        return imageRepository.findByProduct_Id(id);
    }

    public List<ImageEntity> getImagesDistinct(){
        return imageRepository.findDistinctProductId();
    }
    
    public ImageEntity getImageByUserId(int id){
        return imageRepository.findByUser_Id(id);
    }
    
    public ImageEntity findById(int id){
        Optional<ImageEntity> product = imageRepository.findById(id);
        if(product.isPresent()){
            return product.get();
        }else{
            return new ImageEntity();
        }
    }
}
