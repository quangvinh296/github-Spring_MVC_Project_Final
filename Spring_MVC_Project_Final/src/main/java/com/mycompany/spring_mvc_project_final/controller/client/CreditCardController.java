/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller.client;

import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import com.mycompany.spring_mvc_project_final.entities.CreditCardEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.enums.OrderStatus;
import com.mycompany.spring_mvc_project_final.service.CategoryProImpl;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author my
 */
@Controller
public class CreditCardController {

    @Autowired
    private CategoryProImpl categoryService;
    
    @RequestMapping(value = "/creditcard", method = RequestMethod.POST)
    @Transactional(rollbackFor = Exception.class)
    public String addCart(@ModelAttribute("user") UserEntity userForm, Model model,
            @RequestParam("totalBill") double totalBill,
            HttpServletRequest request, HttpSession session) {
        try {
            OrderEntity order = (OrderEntity) session.getAttribute("myorder");

            order.setEmail(userForm.getEmail());
            order.setPhone(userForm.getPhone());
            order.setFullName(userForm.getFullName());
            order.setAddress(userForm.getAddress());
            order.setStatus(OrderStatus.ORDERED);
            order.setTotalOrder(totalBill);
            order.setDateOrder(new Date());

            model.addAttribute("card", new CreditCardEntity());
            return "creditCard";
        } catch (Exception e) {
            return "403";
        }
    }
    
     @ModelAttribute(name = "categories")
    public List<CategoryEntity> getCategories() {
        List<CategoryEntity> categories = categoryService.getCategory();
        if (CollectionUtils.isEmpty(categories)) {
            return new ArrayList<>();
        }
        return categories;
    }
}
