/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.FavoriteEntity;
import com.mycompany.spring_mvc_project_final.repository.FavoriteProRepository;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author my
 */
@Service
@Transactional
public class FavoriteProServiceImpl {

    @Autowired
    private FavoriteProRepository favoriteProRepository;

    public Set<FavoriteEntity> findProductByUserId(int id) {
        return favoriteProRepository.findByUser_Id(id);
    }

    public Set<FavoriteEntity> findProductByProductId(int productid) {
        return favoriteProRepository.findByProduct_Id(productid);
    }

    public void save(FavoriteEntity favorite) {
        favoriteProRepository.save(favorite);
    }

    public FavoriteEntity findByUserIdAndProductId(int userId, int productId ){
        return favoriteProRepository.findByUser_IdAndProduct_Id(userId, productId);
    }
    public void deletefavoriteProduct(int userId, int productId) {
        FavoriteEntity favorite = favoriteProRepository.findByUser_IdAndProduct_Id(userId, productId);
        favoriteProRepository.deleteById(favorite.getId());
    }
}
