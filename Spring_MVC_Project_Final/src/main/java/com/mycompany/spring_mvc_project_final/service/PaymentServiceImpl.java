/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.PaymentEntity;
import com.mycompany.spring_mvc_project_final.repository.PaymentRepository;
import java.util.List;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author my
 */
@Service
@Transactional
public class PaymentServiceImpl {
    
    @Autowired
    private PaymentRepository paymentRepository;
 
    public void save(PaymentEntity payment) {
        paymentRepository.save(payment);
    }
    
     public List<PaymentEntity> getPaysByOrderID(int orderID) {
        return  paymentRepository.findByOrder_Id(orderID);
    }

}
