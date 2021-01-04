/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import com.mycompany.spring_mvc_project_final.repository.UserRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

/**
 *
 * @author my
 */
@Service
@Transactional
public class UserServiceImpl {

    @Autowired
    private UserRepository userRepository;

    
    public List<UserEntity> getUsers() {
        List<UserEntity> users = (List<UserEntity>) userRepository.findAllUser();
        if (!CollectionUtils.isEmpty(users)) {
            return users;
        }
        return new ArrayList<>();
    }

    
    public void save(UserEntity user) {

        userRepository.save(user);
    }

    public UserEntity findUserById(int userId) {
        Optional<UserEntity> user = userRepository.findById(userId);
        if (user.isPresent()) {
            return user.get();
        } else {
            return new UserEntity();
        }
    }

    public UserEntity findUserByEmail(String email) {
        return userRepository.findByEmailLike(email);
    }

    public UserEntity findUserLogin(String email, UserStatus status) {
       return userRepository.findByEmailLikeAndStatus(email,status);


    }

    public UserEntity findUserByToken(String verifi) {
        return userRepository.findByVerificationCodeLike(verifi);
    }
}
