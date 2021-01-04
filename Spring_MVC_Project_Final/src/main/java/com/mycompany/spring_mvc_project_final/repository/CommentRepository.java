/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.CommentEntity;
import java.util.List;
import java.util.Set;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author my
 */
@Repository
public interface CommentRepository extends CrudRepository<CommentEntity, Integer> {

    Set<CommentEntity> findByProduct_Id(int id);
    
    Set<CommentEntity> findByProduct_IdAndUser_Id(int productid,int userId);
}
