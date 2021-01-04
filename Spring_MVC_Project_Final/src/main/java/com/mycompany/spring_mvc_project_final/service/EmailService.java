package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import java.io.UnsupportedEncodingException;
import javax.mail.MessagingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

@Service
public class EmailService {

    @Autowired
    private OrderDetailServiceImpl orderDetailService;

    @Autowired
    private UserServiceImpl userSevice;

    private final TemplateEngine templateEngine;

    private final JavaMailSender javaMailSender;

    public EmailService(TemplateEngine templateEngine, JavaMailSender javaMailSender) {
        this.templateEngine = templateEngine;
        this.javaMailSender = javaMailSender;
    }

    public String sendMail(OrderEntity order, String content, PromotionEntity pro) throws MessagingException, UnsupportedEncodingException {
        Context context = new Context();
        context.setVariable("order", order);
        context.setVariable("content", content);
        context.setVariable("pro", pro);
        context.setVariable("orderDetails", orderDetailService.ordersDetails(order.getId()));
        String subject = "Your order!";
        String senderName = "Sublime OnlineShop";
        String process = templateEngine.process("email", context);
        javax.mail.internet.MimeMessage mimeMessage = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage);
        helper.setFrom("my170417@gmail.com", senderName);
        helper.setSubject(subject);
        helper.setText(process, true);
        helper.setTo(order.getEmail());
        javaMailSender.send(mimeMessage);

        return "Sent";
    }

}
