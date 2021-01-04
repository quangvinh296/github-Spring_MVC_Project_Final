/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.CommentEntity;
import com.mycompany.spring_mvc_project_final.repository.CommentRepository;
import java.util.Optional;
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
public class CommentServiceImpl {
    
    @Autowired
    private CommentRepository commentRepository;
    
    public Set<CommentEntity> findByProductId(int id){
       return commentRepository.findByProduct_Id(id);
       
    }
    
    public CommentEntity findById(int id){
         Optional<CommentEntity> cmt = commentRepository.findById(id);
       if (cmt.isPresent()) {
            return cmt.get();
        } else {
            return new CommentEntity();
        }
    }
    
     public int getTotalItem(int id) {
		return (int) commentRepository.findByProduct_Id(id).size();
	}
     
     public Set<CommentEntity> findByProductandUser(int productId, int userId){
         return commentRepository.findByProduct_IdAndUser_Id(productId, userId);
     }
     
     public void save(CommentEntity comment) {
        commentRepository.save(comment);
    }
     
     public boolean deleteComment(int cmtId) {
        commentRepository.deleteById(cmtId);
        return commentRepository.existsById(cmtId);
    }
}
