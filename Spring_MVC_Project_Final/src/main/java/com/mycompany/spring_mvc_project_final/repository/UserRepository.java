/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends CrudRepository<UserEntity, Integer> {

    UserEntity findByEmailLike(String email);
    
    UserEntity findByEmailLikeAndStatus(String email,UserStatus status);
    UserEntity findByVerificationCodeLike(String verifi);
    
    @Query("SELECT DISTINCT a FROM UserEntity a INNER JOIN FETCH a.userRoles r")
    List<UserEntity> findAllUser();
}
