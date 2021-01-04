/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.enums.PromotionStatus;
import com.mycompany.spring_mvc_project_final.repository.PromotionRepository;
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
public class PromotionServiceImpl {

    @Autowired
    private PromotionRepository promotionRepository;

    public List<PromotionEntity> getPromotions() {
        return (List<PromotionEntity>) promotionRepository.findAll();
    }

    public void save(PromotionEntity promotion) {
        promotionRepository.save(promotion);
    }

      public void saveAll(List<PromotionEntity> promotion) {
        promotionRepository.saveAll(promotion);
    }
      
    public PromotionEntity findPromotionById(int promotionId) {
        Optional<PromotionEntity> promotion = promotionRepository.findById(promotionId);
        if (promotion.isPresent()) {
            return promotion.get();
        } else {
            return new PromotionEntity();
        }
    }
//    
//    public List<PromotionEntity> getPromotions(String code, PromotionStatus status){
//        return promotionRepository.findByCodeLikeAndStatusLike(code, status);
//    }
    public PromotionEntity findPromotionByCode(String code) {
        return promotionRepository.findByCodeLike(code);
    }

    public List<PromotionEntity> findProByCategoryId(int cateId) {
        return (List<PromotionEntity>) promotionRepository.findByCategories_Id(cateId);
    }

    public PromotionEntity findProByName(String name) {
        return promotionRepository.findByNameContaining(name);
    }
    
    public List<PromotionEntity> getPromotionsActive() {
        return (List<PromotionEntity>) promotionRepository.findAllPromotionActive();
    }

}
