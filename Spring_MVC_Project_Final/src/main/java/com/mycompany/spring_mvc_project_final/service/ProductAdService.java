/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mycompany.spring_mvc_project_final.repository.CategoryAdRepository;
import com.mycompany.spring_mvc_project_final.repository.ProductAdRepository;
import com.mycompany.spring_mvc_project_final.repository.ProductRepository;
import java.util.Optional;
import java.util.Set;


@Service
public class ProductAdService {
    
    @Autowired
    private ProductAdRepository productAdRepository;
    
     public List<ProductEntity> getProducts() {
        return (List<ProductEntity>) productAdRepository.findAll();
    }
     
     public void saveAll(List<ProductEntity> products) {
        productAdRepository.saveAll(products);
    }

    public void save(ProductEntity product) {
        productAdRepository.save(product);
    }
    
    public ProductEntity findById(int id){
        Optional<ProductEntity> product = productAdRepository.findById(id);
        if(product.isPresent()){
            return product.get();
        }else{
            return new ProductEntity();
        }
    }
}
