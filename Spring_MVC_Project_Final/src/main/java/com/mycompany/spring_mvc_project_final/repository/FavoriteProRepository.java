/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.FavoriteEntity;
import java.util.Set;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author my
 */
@Repository
public interface FavoriteProRepository extends CrudRepository<FavoriteEntity, Integer> {

    Set<FavoriteEntity> findByUser_Id(int id);

    FavoriteEntity findByUser_IdAndProduct_Id(int userid, int productId);

    Set<FavoriteEntity> findByProduct_Id(int id);
}
