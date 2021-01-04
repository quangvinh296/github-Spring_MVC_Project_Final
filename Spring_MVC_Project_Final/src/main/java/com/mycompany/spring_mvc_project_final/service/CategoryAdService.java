/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mycompany.spring_mvc_project_final.repository.CategoryAdRepository;
import java.util.ArrayList;
import java.util.Optional;
import java.util.Set;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.WebDataBinder;

@Service
public class CategoryAdService {

    @Autowired
    private CategoryAdRepository categoryAdRepository;

    public List<CategoryEntity> getCategories() {
        List<CategoryEntity> categories = (List<CategoryEntity>) categoryAdRepository.findAllCategory();
        if(!CollectionUtils.isEmpty(categories)){
           return categories;
        }
        return new ArrayList<>();
    }

    public void saveAll(List<CategoryEntity> categories) {
        categoryAdRepository.saveAll(categories);
    }

    public void save(CategoryEntity category) {
        categoryAdRepository.save(category);
    }

    public CategoryEntity findById(int id) {
        Optional<CategoryEntity> category = categoryAdRepository.findById(id);
        if (category.isPresent()) {
            return category.get();
        } else {
            return new CategoryEntity();
        }
    }
}
