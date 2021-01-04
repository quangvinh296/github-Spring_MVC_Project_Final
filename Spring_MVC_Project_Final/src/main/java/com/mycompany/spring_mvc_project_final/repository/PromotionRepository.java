/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.enums.PromotionStatus;
import java.util.List;
import org.springframework.data.jpa.repository.Query;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author my
 */
@Repository
public interface PromotionRepository extends CrudRepository<PromotionEntity, Integer> {

    PromotionEntity findByCodeLike(String code);

    List<PromotionEntity> findByCodeLikeAndStatusLike(String code, PromotionStatus status);

    List<PromotionEntity> findByCategories_Id(int categoryId);

    PromotionEntity findByNameContaining(String name);

    @Query("SELECT DISTINCT p FROM PromotionEntity p LEFT JOIN FETCH p.categories c")
    List<PromotionEntity> findAllPromotion();

    @Query("SELECT DISTINCT p FROM PromotionEntity p LEFT JOIN FETCH p.categories c WHERE p.status = 'ACTIVE'")
    List<PromotionEntity> findAllPromotionActive();

}
