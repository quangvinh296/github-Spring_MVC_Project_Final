/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import java.util.List;
import java.util.Set;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 *
 * @author my
 */
@Repository
public interface ProductRepository extends JpaRepository<ProductEntity, Integer> {

    Set<ProductEntity> findByNameContaining(String name);

    Set<ProductEntity> findByCategory_Name(String category);

    Set<ProductEntity> findByCategory_NameOrderByUpdateDateDesc(String nameCategory);

    Set<ProductEntity> findByCategory_NameOrderByPriceDesc(String nameCategory);

    Set<ProductEntity> findByCategory_NameOrderByQuantitySaleDesc(String nameCategory);

    Page<ProductEntity> findAllByOrderByPriceDesc(Pageable pageable);

    Page<ProductEntity> findAllByOrderByUpdateDateDesc(Pageable pageable);

    Page<ProductEntity> findAllByOrderByQuantitySaleDesc(Pageable pageable);

    Set<ProductEntity> findTop8ByOrderByUpdateDateDesc();
    
    @Query(value = "SELECT p FROM ProductEntity p", nativeQuery = true)
    List<ProductEntity> findProducts(Pageable pageable);
    
    
}
