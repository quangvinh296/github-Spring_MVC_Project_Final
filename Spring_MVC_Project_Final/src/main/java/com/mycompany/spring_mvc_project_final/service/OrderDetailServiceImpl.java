/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.OrderDetailEntity;
import com.mycompany.spring_mvc_project_final.repository.OrderDetailRepository;
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
public class OrderDetailServiceImpl {

    @Autowired
    private OrderDetailRepository orderdetailRepository;

    public OrderDetailEntity findById(int id) {
        Optional<OrderDetailEntity> orderLine = orderdetailRepository.findById(id);
        if (orderLine.isPresent()) {
            return orderLine.get();
        } else {
            return new OrderDetailEntity();
        }
    }

    public void updateQuantity(OrderDetailEntity orderDetail) {
        orderdetailRepository.save(orderDetail);
    }

    public List<OrderDetailEntity> getAllOrderDetails() {
        List<OrderDetailEntity> orderdetails = (List<OrderDetailEntity>) orderdetailRepository.findAllOrderDetail();
        if(!CollectionUtils.isEmpty(orderdetails)){
           return orderdetails;
        }
        return new ArrayList<>();
    }
    
    public List<OrderDetailEntity> getOrderDetails() {
        return (List<OrderDetailEntity>) orderdetailRepository.findAll();
    }

    public List<OrderDetailEntity> getOrderDetailByorderId(int orderId){
        return orderdetailRepository.findByOrder_Id(orderId);
    }
    public void save(OrderDetailEntity orderDetail) {
        orderdetailRepository.save(orderDetail);
    }

    public List<OrderDetailEntity> ordersDetails(int orderId) {
        return orderdetailRepository.findByOrder_Id(orderId);
    }
}
