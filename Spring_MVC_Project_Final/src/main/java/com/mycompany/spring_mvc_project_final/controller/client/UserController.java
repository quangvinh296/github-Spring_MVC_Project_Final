/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller.client;

import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import com.mycompany.spring_mvc_project_final.entities.CommentEntity;
import com.mycompany.spring_mvc_project_final.entities.CreditCardEntity;
import com.mycompany.spring_mvc_project_final.entities.FavoriteEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import com.mycompany.spring_mvc_project_final.entities.PaymentEntity;
import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.enums.OrderStatus;
import com.mycompany.spring_mvc_project_final.enums.PaymentStatus;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import com.mycompany.spring_mvc_project_final.service.CategoryProImpl;
import com.mycompany.spring_mvc_project_final.service.CommentServiceImpl;
import com.mycompany.spring_mvc_project_final.service.CreditCardServiceImpl;
import com.mycompany.spring_mvc_project_final.service.EmailService;
import com.mycompany.spring_mvc_project_final.service.FavoriteProServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ImageServiceImpl;
import com.mycompany.spring_mvc_project_final.service.OrderDetailServiceImpl;
import com.mycompany.spring_mvc_project_final.service.OrderServiceImpl;
import com.mycompany.spring_mvc_project_final.service.PaymentServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ProductServiceImpl;
import com.mycompany.spring_mvc_project_final.service.UserServiceImpl;
import com.mycompany.spring_mvc_project_final.utils.UserUtils;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserServiceImpl userService;

    @Autowired
    private CategoryProImpl categoryService;

    @Autowired
    private ProductServiceImpl productService;

    @Autowired
    private CommentServiceImpl commentService;

    @Autowired
    private FavoriteProServiceImpl favoriteService;

    @Autowired
    private OrderServiceImpl orderService;

    @Autowired
    private ImageServiceImpl imageService;

    @Autowired
    private OrderDetailServiceImpl orderDetailService;

    @Autowired
    private CreditCardServiceImpl cardService;

    @Autowired
    private PaymentServiceImpl paymentService;

    @Autowired
    private EmailService emailService;

    @RequestMapping("/home")
    public String viewHome(Model model, HttpServletRequest request, HttpSession session) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        UserEntity user = userService.findUserByEmail(username);
        model.addAttribute("image", imageService.getImageByUserId(user.getId()));
        model.addAttribute("user", user);
        return "user/home";

    }

    @RequestMapping("/update")
    public String UpdateInfo(Model model) {
        String username = UserUtils.User();
        UserEntity user = userService.findUserByEmail(username);
        model.addAttribute("user", user);
        return "user/updateAccount";
    }

    @RequestMapping(value = "/updateAccount", method = RequestMethod.POST)
    public String save(Model model, @ModelAttribute("user") UserEntity user) {
        UserEntity newUser = userService.findUserById(user.getId());
        newUser.setFullName(user.getFullName());
        newUser.setBirthDate(user.getBirthDate());
        newUser.setAddress(user.getAddress());
        newUser.setPhone(user.getPhone());
        userService.save(newUser);
        return "redirect:/user/home";
    }

    @RequestMapping("/updatePass")
    public String UpdatePass(Model model, @RequestParam(name = "error", required = false) String error) {
        model.addAttribute("error", error);
        model.addAttribute("message", "changePassword");
        return "user/updateAccount";
    }

    @RequestMapping(value = "/updatePass", method = RequestMethod.POST)
    public String savePass(Model model,
            @RequestParam("newpass") String newpass) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(10);;
        String username = UserUtils.User();
        UserEntity user = userService.findUserByEmail(username);
        user.setPassword(encoder.encode(newpass));
        return "redirect:/user/updatePass?error=successfully change";

    }

    @RequestMapping("/history")
    public String historyOrder(Model model) {
        String username = UserUtils.User();
        UserEntity user = userService.findUserByEmail(username);

        model.addAttribute("orders", orderService.findByUserId(user.getId()));
        return "user/historyProduct";
    }

    @RequestMapping("/favorite")
    public String favoriteList(Model model) {
        String username = UserUtils.User();
        UserEntity user = userService.findUserByEmail(username);
        model.addAttribute("images", imageService.getImagesDistinct());
        model.addAttribute("favorites", favoriteService.findProductByUserId(user.getId()));
        return "user/favoriteProduct";
    }

    @RequestMapping("/favorite/{id}")
    public String favoriteProduct(Model model,
            @PathVariable("id") int productId) {
        String username = UserUtils.User();
        UserEntity user = userService.findUserByEmail(username);
        ProductEntity product = productService.findProductById(productId);
        if (favoriteService.findByUserIdAndProductId(user.getId(), productId) == null) {
            FavoriteEntity favorite = new FavoriteEntity();
            favorite.setProduct(product);
            favorite.setUser(user);
            favoriteService.save(favorite);
        }
        return "redirect:/productDetail/" + productId;
    }

    @RequestMapping("/removeFavorite/{namePage}/{id}")
    public String removeFavorite(Model model,
            @PathVariable("id") int productId,
            @PathVariable("namePage") String namePage) {
        String username = UserUtils.User();
        UserEntity user = userService.findUserByEmail(username);
        favoriteService.deletefavoriteProduct(user.getId(), productId);
        if (namePage.equalsIgnoreCase("favoriteProduct")) {
            return "redirect:/user/favorite";
        }
        if (namePage.equalsIgnoreCase("productDetail")) {
            return "redirect:/productDetail/" + productId;
        }
        return "redirect:/user/favorite";
    }

    @RequestMapping("/comment/{idProduct}")
    public String saveComment(Model model,
            @ModelAttribute("cmt") CommentEntity comment,
            @PathVariable("idProduct") int productId) {
        Date date = java.util.Calendar.getInstance().getTime();
        String username = UserUtils.User();
        UserEntity user = userService.findUserByEmail(username);
        ProductEntity product = productService.findProductById(productId);
        comment.setProduct(product);
        comment.setUser(user);
        comment.setContentDate(new Date());
        commentService.save(comment);
        return "redirect:/productDetail/" + productId + "?message1=comment";
    }

    @RequestMapping("/deleteCmt/{idCmt}")
    public String deleteComment(Model model, @PathVariable("idCmt") int idCmt) {
        CommentEntity cmt = commentService.findById(idCmt);
        int productId = cmt.getProduct().getId();
        model.addAttribute("categories", categoryService.getCategory());
        if (cmt.getId() > 0) {
            if (!commentService.deleteComment(idCmt)) {
                return "redirect:/productDetail/" + productId + "?message1=comment";
            } else {
                return "redirect:/productDetail/" + productId + "?message1=comment";
            }
        } else {
            return "redirect:/productDetail/" + productId + "?message1=comment";
        }
    }

    @RequestMapping("/{namePage}/{orderId}")
    public String cancelOrder(Model model, @PathVariable("orderId") int orderId,
            @PathVariable("namePage") String namePage) throws UnsupportedEncodingException, MessagingException {
        String username = UserUtils.User();
        UserEntity user = userService.findUserByEmail(username);
        OrderEntity order = orderService.findOrderById(orderId);
        if (order.getStatus().equals(OrderStatus.CONFIRM)) {
            order.setStatus(OrderStatus.CANCEL);
            List<OrderDetailEntity> orderDetails = orderDetailService.ordersDetails(orderId);
            for (OrderDetailEntity orderDetail : orderDetails) {
                ProductEntity product = productService.findProductById(orderDetail.getProduct().getId());
                product.setQuantityProduct(product.getQuantityProduct() + orderDetail.getQuantity());
                product.setQuantitySale(product.getQuantitySale() + orderDetail.getQuantity());
                productService.save(product);
            }
            List<PaymentEntity> pays = paymentService.getPaysByOrderID(orderId);
            for (PaymentEntity pay : pays) {
                double balanceNew = pay.getCreditcard().getBalance() - pay.getAmount() * 0.8;
                CreditCardEntity card = cardService.findCardById(pay.getCreditcard().getCardId());
                card.setBalance(balanceNew);
                cardService.saveCard(card);
                pay.setStatus(PaymentStatus.REFUND);
                paymentService.save(pay);
            }

            orderService.save(order);

            String content = "cancel";
            PromotionEntity pro = new PromotionEntity();
            emailService.sendMail(order, content, pro);
        }
        if (order.getStatus().equals(OrderStatus.SHIPPING)) {
            order.setStatus(OrderStatus.WAITING);
            orderService.save(order);
            model.addAttribute("cancel", "After 15 minutes, a staff will call and confirm this order");
        }

        if (namePage.equalsIgnoreCase("cancelOrder")) {
            model.addAttribute("orderDetail", orderDetailService.getOrderDetails());
            model.addAttribute("order", orderService.findOrderById(orderId));
            model.addAttribute("message", "findOrder");
            return "aboutUs";
        }
        if (namePage.equalsIgnoreCase("history")) {
            model.addAttribute("orderDetail", orderDetailService.getOrderDetails());
            model.addAttribute("orders", orderService.findByUserId(user.getId()));
            return "user/historyProduct";
        }
        return "aboutUs";
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
