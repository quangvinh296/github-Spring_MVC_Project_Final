/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.repository.PromotionRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

@Service

public class PromotionAdService {

    @Autowired
    private PromotionRepository promotionRepository;

    public List<PromotionEntity> getPromotions() {
        List<PromotionEntity> promotions = (List<PromotionEntity>) promotionRepository.findAllPromotion();
        if(!CollectionUtils.isEmpty(promotions)){
           return promotions;
        }
        return new ArrayList<>();
    }
    
    public void saveAll(List<PromotionEntity> promotion) {
        promotionRepository.saveAll(promotion);
    }

    public void save(PromotionEntity promotion) {
        promotionRepository.save(promotion);
    }

    public PromotionEntity findPromotionById(int promotionId) {
        Optional<PromotionEntity> promotion = promotionRepository.findById(promotionId);
        if (promotion.isPresent()) {
            return promotion.get();
        } else {
            return new PromotionEntity();
        }
    }

//    public PromotionEntity findPromotionByCode(String code) {
//        return promotionRepository.findByCode(code);
//    }
}
