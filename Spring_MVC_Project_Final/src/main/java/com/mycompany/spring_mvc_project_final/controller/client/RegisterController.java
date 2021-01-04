/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller.client;

import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.entities.UserRoleEntity;
import com.mycompany.spring_mvc_project_final.enums.Gender;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import com.mycompany.spring_mvc_project_final.service.CategoryProImpl;
import com.mycompany.spring_mvc_project_final.service.UserRoleServiceImpl;
import com.mycompany.spring_mvc_project_final.service.UserServiceImpl;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.bytebuddy.utility.RandomString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
public class RegisterController {

    @Autowired
    private UserServiceImpl userService;

    @Autowired
    private UserRoleServiceImpl roleService;

    @Autowired
    public JavaMailSender emailSender;

    @Autowired
    private CategoryProImpl categoryService;

    @ModelAttribute(name = "categories")
    public List<CategoryEntity> getCategories() {
        List<CategoryEntity> categories = categoryService.getCategory();
        if (CollectionUtils.isEmpty(categories)) {
            return new ArrayList<>();
        }
        return categories;
    }

    @RequestMapping("/register")
    public String registerPage(Model model) {

        model.addAttribute("genders", Gender.values());
        model.addAttribute("user", new UserEntity());
        return "register";
    }

    @RequestMapping(value = {"/Register"}, method = RequestMethod.POST)
    @Transactional(rollbackFor = Exception.class)
    public String register(Model model, HttpServletRequest request, HttpServletResponse response,
            @ModelAttribute("user") UserEntity useInput) {
        try {
            UserEntity user = userService.findUserLogin(useInput.getEmail(), UserStatus.ACTIVE);

            if (user != null) {
                model.addAttribute("message1", "Email registered");

            } else {
                user = new UserEntity();
                BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
                user.setPassword(encoder.encode(useInput.getPassword()));
                user.setFullName(useInput.getFullName());
                user.setAddress(useInput.getAddress());
                user.setPhone(useInput.getPhone());
                user.setBirthDate(useInput.getBirthDate());
                user.setEmail(useInput.getEmail());
                user.setStatus(UserStatus.UN_ACTIVE);
                user.setGender(useInput.getGender());
                UserRoleEntity role = roleService.findRoleById(1);
                Set<UserRoleEntity> roles = new HashSet<>();
                roles.add(role);
                user.setUserRoles(roles);

                String randomCode = RandomString.make(64);
                user.setVerificationCode(randomCode);

                userService.save(user);
                SimpleMailMessage message = new SimpleMailMessage();

                message.setTo(useInput.getEmail());
                message.setSubject("Complete Registration!");
                message.setText("To verification your account, please click here : "
                        + "http://localhost:8080/Spring_MVC_Project_Final/verification?token=" + user.getVerificationCode());
                this.emailSender.send(message);
                model.addAttribute("message1", "Thank you for registration. Please check your Email to verification account !");
                ;

            }
            model.addAttribute("genders", Gender.values());
            return "register";
        } catch (Exception e) {
            return "403";
        }
    }

    @RequestMapping("/verification")
    public String verification(@RequestParam("token") String token, Model model, HttpSession session) {

        if (token == null) {
            model.addAttribute("msg", "The link is invalid or broken !");
        } else {
            UserEntity user = userService.findUserByToken(token);
            user.setStatus(UserStatus.ACTIVE);
            userService.save(user);
        }

        return "redirect:/login";
    }
}
