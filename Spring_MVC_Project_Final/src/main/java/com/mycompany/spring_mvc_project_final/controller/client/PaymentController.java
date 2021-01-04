/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller.client;

import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import com.mycompany.spring_mvc_project_final.entities.CreditCardEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import com.mycompany.spring_mvc_project_final.entities.PaymentEntity;
import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.enums.OrderStatus;
import com.mycompany.spring_mvc_project_final.enums.PaymentStatus;
import com.mycompany.spring_mvc_project_final.enums.PromotionStatus;
import com.mycompany.spring_mvc_project_final.service.CategoryProImpl;
import com.mycompany.spring_mvc_project_final.service.CreditCardServiceImpl;
import com.mycompany.spring_mvc_project_final.service.EmailService;
import com.mycompany.spring_mvc_project_final.service.OrderDetailServiceImpl;
import com.mycompany.spring_mvc_project_final.service.OrderServiceImpl;
import com.mycompany.spring_mvc_project_final.service.PaymentServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ProductServiceImpl;
import com.mycompany.spring_mvc_project_final.service.PromotionServiceImpl;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.mail.MessagingException;
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
public class PaymentController {

    @Autowired
    private CategoryProImpl categoryService;

    @Autowired
    private CreditCardServiceImpl cardService;

    @Autowired
    private OrderServiceImpl orderService;

    @Autowired
    private OrderDetailServiceImpl orderDetailService;

    @Autowired
    private ProductServiceImpl productService;

    @Autowired
    public PromotionServiceImpl promotionService;

    @Autowired
    public PaymentServiceImpl paymentService;

    @Autowired
    private EmailService emailService;

    @RequestMapping(value = "/payment", method = RequestMethod.POST)
//    @Transactional(rollbackFor = Exception.class)
    public String finishCart(Model model, @ModelAttribute("card") CreditCardEntity getCard,
            @RequestParam("expiry") String expiry,
            @RequestParam("totalBill") double totalBill,
            HttpServletRequest request, HttpSession session) throws MessagingException, UnsupportedEncodingException {
   //     try {
            OrderEntity order = (OrderEntity) session.getAttribute("myorder");
            CreditCardEntity card = cardService.getCreditCard(getCard.getCardNumber());

            if (card == null) {
                model.addAttribute("error", "CreditCard not exists !!!");
                model.addAttribute("categories", categoryService.getCategory());
                model.addAttribute("card", new CreditCardEntity());
                model.addAttribute("totalBill", totalBill);
                return "creditCard";
            } else {
                String[] expiryParts = expiry.split("/");
                int exipyMonth = Integer.parseInt(expiryParts[0].trim());
                int expiryYear = Integer.parseInt(expiryParts[1].trim());
                if (card.getCvvcode() != getCard.getCvvcode() || !card.getOwnerName().equals(getCard.getOwnerName())
                        || card.getExpiryMonth() != exipyMonth || card.getExpiryYear() != expiryYear) {
                    model.addAttribute("error", "Wrong CreditCard information !!!");
                    model.addAttribute("card", new CreditCardEntity());
                    model.addAttribute("totalBill", totalBill);
                    model.addAttribute("categories", categoryService.getCategory());
                    return "creditCard";
                } else {
                    if (card.getBalance() < totalBill) {
                        model.addAttribute("error", "Balances not enough money !!!");
                        model.addAttribute("card", new CreditCardEntity());
                        model.addAttribute("totalBill", totalBill);
                        return "creditCard";
                    } else {
                        order.setOrderUId(generateUID());
                        order.setStatus(OrderStatus.CONFIRM);
                        orderService.save(order);

                        PaymentEntity payment = new PaymentEntity();
                        payment.setOrder(order);
                        payment.setAmount(totalBill);
                        payment.setPaymentDate(new Date());
                        payment.setCreditcard(card);
                        payment.setStatus(PaymentStatus.PAYMENT_ORDER);
                        paymentService.save(payment);

                        card.setBalance(card.getBalance() - totalBill);
                        cardService.saveCard(card);

                        PromotionEntity pro = (PromotionEntity) session.getAttribute("promotionCode");
                        if (pro != null) {
                            pro.setStatus(PromotionStatus.NOT_ACTIVE);
                            promotionService.save(pro);
                        }

                        HashMap<Integer, OrderDetailEntity> orderDetails = (HashMap<Integer, OrderDetailEntity>) session.getAttribute("myCart");
                        for (Map.Entry<Integer, OrderDetailEntity> item : orderDetails.entrySet()) {
                            //save order detail
                            OrderDetailEntity orderDt = item.getValue();
                            orderDt.setOrder(order);
                            orderDetailService.save(orderDt);

                            // update quantity for product
                            ProductEntity product = productService.findProductById(orderDt.getProduct().getId());
                            product.setQuantityProduct(product.getQuantityProduct() - orderDt.getQuantity());
                            product.setQuantitySale(product.getQuantitySale() + orderDt.getQuantity());

                            productService.save(product);
                        }

                        String content = "confirm";
                        emailService.sendMail(order, content, pro);

                        request.getSession().removeAttribute("myCart");
                        request.getSession().removeAttribute("myorder");
                        request.getSession().removeAttribute("myCartTotal");
                        request.getSession().removeAttribute("myCartTotalQuantity");
                        request.getSession().removeAttribute("promotionCode");
                        model.addAttribute("orderUID", order.getOrderUId());
                        
                         return "finishCart";
                    }
                }
            }
//        } catch (Exception e) {
//            return "403";
//        }
    }

    @ModelAttribute(name = "categories")
    public List<CategoryEntity> getCategories() {
        List<CategoryEntity> categories = categoryService.getCategory();
        if (CollectionUtils.isEmpty(categories)) {
            return new ArrayList<>();
        }
        return categories;
    }

    private String generateUID() {
        String maxId = orderService.getMaxOrderId();
        int id;
        if (maxId == null) {
            id = 1;
        } else {
            id = Integer.parseInt(maxId);
        }
        Random rnd = new Random();
        int n = 1000 + rnd.nextInt(9000);
        int m = 1000 + rnd.nextInt(9000);
        String uid = n + "-" + m + (String.format("%05d", id + 1));
        return uid;
    }
    
   
     
}


