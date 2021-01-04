/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import com.mycompany.spring_mvc_project_final.repository.CategoryAdRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

/**
 *
 * @author my
 */
@Service
@Transactional
public class CategoryProImpl {
    
    @Autowired
    private CategoryAdRepository categoryProRepository;
    
     public List<CategoryEntity> getCategory() {
        return (List<CategoryEntity>) categoryProRepository.findAll();
    }
   
    public void saveAll(List<CategoryEntity> categories) {
        categoryProRepository.saveAll(categories);
    }

    public void save(CategoryEntity category) {
        categoryProRepository.save(category);
    }

    public CategoryEntity findById(int id) {
        Optional<CategoryEntity> category = categoryProRepository.findById(id);
        if (category.isPresent()) {
            return category.get();
        } else {
            return new CategoryEntity();
        }
    }
    
          public List<CategoryEntity> getCategories() {
        List<CategoryEntity> categories = (List<CategoryEntity>) categoryProRepository.findAllCategory();
        if(!CollectionUtils.isEmpty(categories)){
           return categories;
        }
        return new ArrayList<>();
    }
}
