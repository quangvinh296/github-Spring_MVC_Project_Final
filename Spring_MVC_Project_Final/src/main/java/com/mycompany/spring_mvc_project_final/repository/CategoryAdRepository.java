/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import java.util.List;
import java.util.Set;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author my
 */
@Repository 
public interface CategoryAdRepository  extends JpaRepository<CategoryEntity, Integer> {
@Query("SELECT DISTINCT c FROM CategoryEntity c LEFT JOIN FETCH c.promotions p")
    List<CategoryEntity> findAllCategory();
    
    //List<CategoryEntity> findByPromotion_Id(int categoryId);
}
