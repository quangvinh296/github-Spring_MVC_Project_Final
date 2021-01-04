/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller.admin;

import com.lowagie.text.DocumentException;
import com.mycompany.spring_mvc_project_final.entities.CategoryEntity;
import com.mycompany.spring_mvc_project_final.entities.CreditCardEntity;
import com.mycompany.spring_mvc_project_final.entities.ImageEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderPDFExporter1;

import com.mycompany.spring_mvc_project_final.entities.PaymentEntity;
import com.mycompany.spring_mvc_project_final.entities.ProductEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.entities.UserRoleEntity;
import com.mycompany.spring_mvc_project_final.enums.Gender;
import com.mycompany.spring_mvc_project_final.enums.OrderStatus;
import com.mycompany.spring_mvc_project_final.enums.PaymentStatus;
import com.mycompany.spring_mvc_project_final.enums.ProductStatus;
import com.mycompany.spring_mvc_project_final.enums.PromotionStatus;
import com.mycompany.spring_mvc_project_final.enums.Role;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import com.mycompany.spring_mvc_project_final.service.CategoryAdService;
import com.mycompany.spring_mvc_project_final.service.CreditCardServiceImpl;
import com.mycompany.spring_mvc_project_final.service.EmailService;
import com.mycompany.spring_mvc_project_final.service.ImageServiceImpl;
import com.mycompany.spring_mvc_project_final.service.OrderDetailServiceImpl;
import com.mycompany.spring_mvc_project_final.service.OrderServiceImpl;
import com.mycompany.spring_mvc_project_final.service.PaymentServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ProductAdService;
import com.mycompany.spring_mvc_project_final.service.PromotionAdService;
import com.mycompany.spring_mvc_project_final.service.UserRoleServiceImpl;
import com.mycompany.spring_mvc_project_final.service.UserServiceImpl;
import com.mycompany.spring_mvc_project_final.utils.SecurityUtils;
import com.mycompany.spring_mvc_project_final.utils.UserUtils;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.mail.MessagingException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.bytebuddy.utility.RandomString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserServiceImpl userService;

    @Autowired
    private UserRoleServiceImpl roleService;

    @Autowired
    public JavaMailSender emailSender;

    @Autowired
    private CategoryAdService categoryService;

    @Autowired
    private ProductAdService productService;

    @Autowired
    private ImageServiceImpl imageService;

    @Autowired
    private PromotionAdService promotionService;

    @Autowired
    private OrderDetailServiceImpl orderDetailService;

    @Autowired
    private OrderServiceImpl orderService;

    @Autowired
    private PaymentServiceImpl paymentService;

    @Autowired
    private CreditCardServiceImpl cardService;

    @Autowired
    private EmailService emailService;

    @RequestMapping("/home")
    public String viewHome(Model model) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        UserEntity checkrole = userService.findUserByEmail(username);
        if (checkrole.getStatus().equals(UserStatus.ACTIVE)) {
            List<UserEntity> user = userService.getUsers();
            List<CategoryEntity> category = categoryService.getCategories();
            List<ProductEntity> product = productService.getProducts();
            List<PromotionEntity> promotion = promotionService.getPromotions();
            List<OrderEntity> order = orderService.getOrders();
            int userSize = user.size();
            int categorySize = category.size();
            int productSize = product.size();
            int promotionSize = promotion.size();
            int orderSize = order.size();
            
            model.addAttribute("categorySize", categorySize);
            model.addAttribute("productSize", productSize);
            model.addAttribute("promotionSize", promotionSize);
            model.addAttribute("orderSize", orderSize);
            model.addAttribute("userSize", userSize);
            model.addAttribute("user", userService.findUserByEmail(username));
            model.addAttribute("users", userService.getUsers());
            model.addAttribute("message", "Hi " + username);
            model.addAttribute("activehome", "active");
            return "admin/home3";
        }
        return "redirect:/logout";
    }

    @RequestMapping(value = {"/listAdAccount"}, method = RequestMethod.GET)
    public String listAdAccount(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message) {
        String username = UserUtils.User();
        model.addAttribute("activeuser", "active");
        model.addAttribute("user", userService.findUserByEmail(username));
        model.addAttribute("accounts", userService.getUsers());
        model.addAttribute("ACTIVE", UserStatus.ACTIVE);
        model.addAttribute("LOCK", UserStatus.LOCK);
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "admin/listAdAccount";
    }

    @RequestMapping("/add-account")
    public String addAccount(Model model,
            @RequestParam(name = "message", required = false) String message) {
        String username = UserUtils.User();
        model.addAttribute("user", userService.findUserByEmail(username));
        model.addAttribute("account", new UserEntity());
        model.addAttribute("accounts", userService.getUsers());
        model.addAttribute("userroles", roleService.getRoles());
        model.addAttribute("genders", Gender.values());
        model.addAttribute("status", UserStatus.values());
        model.addAttribute("action", "addaccount");
        model.addAttribute("activeuser", "active");
        return "admin/accountForm";
    }

    @RequestMapping(value = "/addaccount", method = RequestMethod.POST)
    @Transactional(rollbackFor = Exception.class)
    public String createAccount(Model model,
            HttpServletRequest request,
            HttpServletResponse response,
            @ModelAttribute("user") UserEntity useInput) {
        String username = UserUtils.User();
        model.addAttribute("user", userService.findUserByEmail(username));
        try {
            UserEntity user = userService.findUserLogin(useInput.getEmail(), UserStatus.UN_ACTIVE);

            if (user != null) {
                model.addAttribute("message1", "Email registered");

            } else {
                user = new UserEntity();
                BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
                String randomPass = RandomString.make(20);
                user.setPassword(encoder.encode(randomPass));
                user.setFullName(useInput.getFullName());
                user.setAddress(useInput.getAddress());
                user.setPhone(useInput.getPhone());
                user.setBirthDate(useInput.getBirthDate());
                user.setEmail(useInput.getEmail());
                user.setStatus(UserStatus.UN_ACTIVE);
                user.setGender(useInput.getGender());
                String[] userRolesIds = request.getParameterValues("userRoles.id");
                if (userRolesIds != null) {
                    Set<UserRoleEntity> userRole = new HashSet<>();
                    Set<UserEntity> users = new HashSet<>();
                    users.add(useInput);
                    for (int i = 0; i < userRolesIds.length; i++) {
                        UserRoleEntity userRoles = roleService.findRoleById(Integer.valueOf(userRolesIds[i]));
                        userRoles.setUsers(users);
                        userRole.add(userRoles);
                    }
                    useInput.setUserRoles(userRole);
                    user.setUserRoles(useInput.getUserRoles());
                }
                String randomCode = RandomString.make(64);
                user.setVerificationCode(randomCode);

                userService.save(user);

                SimpleMailMessage message = new SimpleMailMessage();

                message.setTo(useInput.getEmail());
                message.setSubject("Hey! " + user.getFullName() + " ! Complete Registration!");
                message.setText("Your default password: ( " + randomPass + " ) - Login and change Password NOW -"
                        + "To verification your account, please click here : "
                        + "http://localhost:8082/Spring_MVC_Project_Final/verification?token=" + user.getVerificationCode()
                );
                this.emailSender.send(message);
                model.addAttribute("message1", "Thank you for registration. Please check your Email to verification account !");

            }
            return "redirect:/admin/listAdAccount";
        } catch (Exception e) {
            return "403";
        }
    }

    @RequestMapping("/my-account/{accountId}")
    public String myAccount(Model model,
            @PathVariable("accountId") int accountId) {

        UserEntity user = userService.findUserById(accountId);
        model.addAttribute("user", user);
        return "admin/myaccount";
    }

    @RequestMapping("/lock-account/{accountId}")
    public String lockaccount(Model model, @PathVariable("accountId") int accountId)
            throws UnsupportedEncodingException, MessagingException {

        UserEntity user = userService.findUserById(accountId);

        user.setStatus(UserStatus.LOCK);
        userService.save(user);

        SimpleMailMessage message = new SimpleMailMessage();

        message.setTo(user.getEmail());
        message.setSubject("Hey! " + user.getFullName() + " ! Your Account Problem!");
        message.setText(
                "Your Account: ( " + user.getEmail() + " ) - Your Account is LOCK -  CALL your account department NOW "
        );
        this.emailSender.send(message);
        return "redirect:/admin/listAdAccount";

    }

    @RequestMapping("/active-account/{accountId}")
    public String activeaccount(Model model, @PathVariable("accountId") int accountId)
            throws UnsupportedEncodingException, MessagingException {
        UserEntity user = userService.findUserById(accountId);
        user.setStatus(UserStatus.ACTIVE);
        userService.save(user);

        SimpleMailMessage message = new SimpleMailMessage();

        message.setTo(user.getEmail());
        message.setSubject("Hey! " + user.getFullName() + " ! Congratulation! Your Account Restore!");
        message.setText(
                "Your Account: ( " + user.getEmail() + " ) - Your Account is ACTIVE -  You can Login NOW "
        );
        this.emailSender.send(message);
        return "redirect:/admin/listAdAccount";

    }

    @RequestMapping("/update-account/{accountId}")
    public String updateAccount(Model model,
            @PathVariable("accountId") int accountId) {
        String username = UserUtils.User();
        model.addAttribute("user", userService.findUserByEmail(username));
        UserEntity user = userService.findUserById(accountId);
        if (user.getId() >= 0) {
            model.addAttribute("account", user);
            model.addAttribute("accounts", userService.getUsers());
            model.addAttribute("userroles", roleService.getRoles());
            model.addAttribute("genders", Gender.values());
            model.addAttribute("status", UserStatus.values());
            model.addAttribute("action", "updateaccount");
            return "admin/accountForm";
        } else {
            return "redirect:admin/home?type=error&message=Not found product id: " + accountId;
        }
    }

    @RequestMapping(value = "/updateaccount", method = RequestMethod.POST)
    public String updateAccount(Model model,
            HttpServletRequest request,
            @ModelAttribute("user") UserEntity user) {
        String[] userRolesIds = request.getParameterValues("userRoles.id");
        if (userRolesIds != null) {
            Set<UserRoleEntity> userRole = new HashSet<>();
            Set<UserEntity> users = new HashSet<>();
            users.add(user);
            for (int i = 0; i < userRolesIds.length; i++) {
                UserRoleEntity userRoles = roleService.findRoleById(Integer.valueOf(userRolesIds[i]));
                userRoles.setUsers(users);
                userRole.add(userRoles);
            }
            user.setUserRoles(userRole);
        }
        userService.save(user);
        return "redirect:/admin/home";
    }

    @RequestMapping("/change-password/{accountId}")
    public String changePassword(Model model, HttpServletRequest request, SessionStatus session,
            @PathVariable("accountId") int accountId) {
        String username = UserUtils.User();
        model.addAttribute("user", userService.findUserByEmail(username));
        UserEntity user = userService.findUserById(accountId);
        if (user.getId() >= 0) {
            model.addAttribute("account", user);
            model.addAttribute("accounts", userService.getUsers());
            model.addAttribute("userroles", roleService.getRoles());
            model.addAttribute("genders", Gender.values());
            model.addAttribute("status", UserStatus.values());
            model.addAttribute("action", "changepassword");
            return "admin/changePassForm";
        } else {
            return "redirect:/admin/home?type=error&message=Not found account id: " + accountId;
        }
    }

    @RequestMapping(value = "/changepassword", method = RequestMethod.POST)
    public String changePassword(Model model,
            HttpServletRequest request,
            @ModelAttribute("user") UserEntity useInput, UserEntity user) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        user.setPassword(encoder.encode(useInput.getPassword()));
        String[] userRolesIds = request.getParameterValues("userRoles.id");
        if (userRolesIds != null) {
            Set<UserRoleEntity> userRole = new HashSet<>();
            Set<UserEntity> users = new HashSet<>();
            users.add(user);
            for (int i = 0; i < userRolesIds.length; i++) {
                UserRoleEntity userRoles = roleService.findRoleById(Integer.valueOf(userRolesIds[i]));
                userRoles.setUsers(users);
                userRole.add(userRoles);
            }
            user.setUserRoles(userRole);
        }
        userService.save(user);
        return "redirect:/admin/home";
    }

    @RequestMapping(value = {"/listAdCategory"}, method = RequestMethod.GET)
    public String listAdCategory(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message) {
        String username = UserUtils.User();
        model.addAttribute("user", userService.findUserByEmail(username));
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        model.addAttribute("activecategory", "active");
        return "admin/listAdCategory";
    }

    @RequestMapping("/add-category")
    public String addCategory(Model model,
            @RequestParam(name = "message", required = false) String message) {
        String username = UserUtils.User();
        model.addAttribute("activecategory", "active");
        model.addAttribute("user", userService.findUserByEmail(username));
        model.addAttribute("category", new CategoryEntity());
        model.addAttribute("message", message);
        model.addAttribute("action", "add");
        return "admin/categoryForm";
    }

    @RequestMapping("/update-category/{categoryId}")
    public String updateCategory(Model model,
            @PathVariable("categoryId") int categoryId) {
        String username = UserUtils.User();
        model.addAttribute("activecategory", "active");
        model.addAttribute("user", userService.findUserByEmail(username));
        CategoryEntity category = categoryService.findById(categoryId);
        if (category.getId() >= 0) {
            model.addAttribute("category", category);
            model.addAttribute("action", "update");
            return "admin/categoryForm";
        } else {
            return "redirect:admin/home?type=error&message=Not found product id: " + categoryId;
        }
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String createCategory(Model model,
            HttpServletRequest request,
            @ModelAttribute("category") CategoryEntity category,
            @RequestParam("file") MultipartFile[] files) {
        categoryService.save(category);
        List<String> fileList = uploadFile(request, files);
        if (fileList != null) {
            for (String fileName : fileList) {
                if (!fileName.equalsIgnoreCase("")) {
                    ImageEntity image = new ImageEntity();
                    image.setName(fileName);
                    image.setCategory(category);
                    category.setNamePicture(fileName);
                    imageService.save(image);
                    categoryService.save(category);
                }
            }
        }
        return "redirect:/admin/listAdCategory";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateCategory(Model model,
            HttpServletRequest request,
            @ModelAttribute("category") CategoryEntity category,
            @RequestParam("file") MultipartFile[] files) {
        categoryService.save(category);
        List<String> fileList = uploadFile(request, files);
        if (fileList != null) {
            for (String fileName : fileList) {
                if (!fileName.equalsIgnoreCase("")) {
                    ImageEntity image = new ImageEntity();
                    image.setName(fileName);
                    image.setCategory(category);
                    category.setNamePicture(fileName);
                    imageService.save(image);
                    categoryService.save(category);
                }
            }
        }
        return "redirect:/admin/listAdCategory";
    }

    @RequestMapping(value = {"/listAdProduct"}, method = RequestMethod.GET)
    public String listAdProduct(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message) {
        String username = UserUtils.User();
        model.addAttribute("activeproduct", "active");
        model.addAttribute("user", userService.findUserByEmail(username));
        model.addAttribute("products", productService.getProducts());
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "admin/listAdProduct";
    }

    @RequestMapping("/add-product")
    public String addProduct(Model model) {
        String username = UserUtils.User();
        model.addAttribute("activeproduct", "active");
        model.addAttribute("user", userService.findUserByEmail(username));
        model.addAttribute("product", new ProductEntity());
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("status", ProductStatus.values());
        model.addAttribute("action", "addproduct");
        return "admin/productForm";
    }

    @RequestMapping(value = "/addproduct", method = RequestMethod.POST)
    public String createProduct(Model model,
            HttpServletRequest request,
            @ModelAttribute("product") ProductEntity product,
            @RequestParam("file") MultipartFile[] files) {
        productService.save(product);
        List<String> fileList = uploadFileProduct(request, files);
        if (fileList != null) {
            for (String fileName : fileList) {
                if (!fileName.equalsIgnoreCase("")) {
                    ImageEntity image = new ImageEntity();
                    image.setName(fileName);
                    image.setProduct(product);
                    imageService.save(image);
                }
            }
        }
        return "redirect:/admin/listAdProduct";
    }

    @RequestMapping("/update-product/{productId}")
    public String updateProduct(Model model,
            @PathVariable("productId") int productId) {
        ProductEntity product = productService.findById(productId);

        if (product.getId() >= 0) {
            String username = UserUtils.User();
            model.addAttribute("activeproduct", "active");
            model.addAttribute("images", imageService.getImages());
            model.addAttribute("user", userService.findUserByEmail(username));
            model.addAttribute("product", product);
            model.addAttribute("products", productService.getProducts());
            model.addAttribute("categories", categoryService.getCategories());
            model.addAttribute("status", ProductStatus.values());
            model.addAttribute("action", "updateproduct");
            return "admin/productForm";
        } else {
            return "redirect:admin/home?type=error&message=Not found product id: " + productId;
        }
    }

    @RequestMapping(value = "/updateproduct", method = RequestMethod.POST)
    public String updateProduct(Model model,
            HttpServletRequest request,
            @ModelAttribute("product") ProductEntity product,
            @ModelAttribute("img.name") String img,
            @RequestParam("file") MultipartFile[] files) {
        productService.save(product);
        List<String> fileList = uploadFileProduct(request, files);
        if (fileList != null) {
            for (String fileName : fileList) {
                if (!fileName.equalsIgnoreCase("")) {
                    ImageEntity image = new ImageEntity();
                    image.setName(fileName);
                    image.setProduct(product);
                    imageService.save(image);
                }
            }
        }
        return "redirect:/admin/listAdProduct";
    }

    @RequestMapping(value = "remove-img/{id}")
    public String removeImage(Model model,
            @PathVariable("id") int id) {
        ImageEntity image = imageService.findById(id);
        if (image.getId() > 0) {
            if (imageService.deleteImage(id)) {
                return "redirect:/admin/listAdProduct?type=success&message=Remove Image Success!";
            } else {
                return "redirect:/admin/listAdProduct?type=error&message=Remove Image Fail!";
            }
        } else {
            return "redirect:/admin/listAdProduct?type=error&message=Not found Image id: !" + id;
        }
    }

    @RequestMapping(value = {"/listAdPromotion"}, method = RequestMethod.GET)
    public String listAdPromotion(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message) {
        String username = UserUtils.User();
        model.addAttribute("activepromotion", "active");
        model.addAttribute("user", userService.findUserByEmail(username));
        model.addAttribute("promotions", promotionService.getPromotions());
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "admin/listAdPromotion";
    }

    @RequestMapping("/add-promotion")
    public String addPromotion(Model model) {
        String username = UserUtils.User();
        model.addAttribute("activepromotion", "active");
        model.addAttribute("user", userService.findUserByEmail(username));
        model.addAttribute("promotion", new PromotionEntity());
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("status", PromotionStatus.values());
        model.addAttribute("action", "addpromotion");
        return "admin/promotionForm";
    }

    @RequestMapping("/update-promotion/{promotionId}")
    public String updatePromotion(Model model,
            @PathVariable("promotionId") int promotionId) {
        String username = UserUtils.User();
        model.addAttribute("user", userService.findUserByEmail(username));
        PromotionEntity promotion = promotionService.findPromotionById(promotionId);
        if (promotion.getId() >= 0) {
            model.addAttribute("activepromotion", "active");
            model.addAttribute("promotion", promotion);
            model.addAttribute("promotions", promotionService.getPromotions());
            model.addAttribute("categories", categoryService.getCategories());
            model.addAttribute("status", PromotionStatus.values());
            model.addAttribute("action", "updatepromotion");
            return "admin/promotionForm";
        } else {
            return "redirect:admin/home?type=error&message=Not found product id: " + promotionId;
        }
    }

    @RequestMapping(value = "/addpromotion", method = RequestMethod.POST)
    public String createPromotion(Model model,
            HttpServletRequest request,
            @ModelAttribute("promotion") PromotionEntity promotion) {
        String[] categoryIds = request.getParameterValues("category.id");
        if (categoryIds != null) {
            Set<CategoryEntity> category = new HashSet<>();
            Set<PromotionEntity> promotions = new HashSet<>();
            promotions.add(promotion);
            for (int i = 0; i < categoryIds.length; i++) {
                CategoryEntity categorys = categoryService.findById(Integer.valueOf(categoryIds[i]));
                categorys.setPromotions(promotions);
                category.add(categorys);
            }
            promotion.setCategories(category);

        }
        float fmtdiscount = Float.parseFloat(request.getParameter("discount"));
        promotion.setDiscount(fmtdiscount / 100);
        promotionService.save(promotion);

        return "redirect:/admin/listAdPromotion";
    }

    @RequestMapping(value = "/updatepromotion", method = RequestMethod.POST)
    public String updatePromotion(Model model,
            HttpServletRequest request,
            @ModelAttribute("promotion") PromotionEntity promotion) {
        String[] categoryIds = request.getParameterValues("category.id");
        if (categoryIds != null) {
            Set<CategoryEntity> category = new HashSet<>();
            Set<PromotionEntity> promotions = new HashSet<>();
            promotions.add(promotion);
            for (int i = 0; i < categoryIds.length; i++) {
                CategoryEntity categorys = categoryService.findById(Integer.valueOf(categoryIds[i]));
                categorys.setPromotions(promotions);
                category.add(categorys);
            }
            promotion.setCategories(category);
        }
        float fmtdiscount = Float.parseFloat(request.getParameter("discount"));
        promotion.setDiscount(fmtdiscount / 100);
        promotionService.save(promotion);
        return "redirect:/admin/listAdPromotion";
    }

    @RequestMapping(value = {"/listAdOrder"}, method = RequestMethod.GET)
    public String listAdOrder(Model model, OrderEntity order,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message) {
        String username = UserUtils.User();
        model.addAttribute("activeorder", "active");
        model.addAttribute("user", userService.findUserByEmail(username));
        model.addAttribute("orders", orderService.getAllOrders());
        model.addAttribute("orderdetails", orderDetailService.getAllOrderDetails());
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        model.addAttribute("COMPLETED", OrderStatus.COMPLETED);
        model.addAttribute("CONFIRM", OrderStatus.CONFIRM);
        model.addAttribute("CANCEL", OrderStatus.CANCEL);
        model.addAttribute("WAITING", OrderStatus.WAITING);
        return "admin/listAdOrder";
    }

    @RequestMapping("/order-Detail/{orderUId}")
    public String orderDetail(Model model,
            @PathVariable(name = "orderUId", required = false) String orderUId) {
        OrderEntity order = orderService.findByOrderUid(orderUId);
        String username = UserUtils.User();
        model.addAttribute("activeorder", "active");
        model.addAttribute("user", userService.findUserByEmail(username));
        model.addAttribute("orderUId", orderUId);
        model.addAttribute("orderDetail", orderDetailService.getOrderDetailByorderId(order.getId()));
        return "admin/orderdetail";
    }

    @RequestMapping("/update-order-status/{orderId}")
    public String updateOrderStatus(Model model,
            @PathVariable("orderId") int orderId) {
        OrderEntity order = orderService.findOrderById(orderId);
        if (order.getId() >= 0) {
            String username = UserUtils.User();
            model.addAttribute("activeorder", "active");
            model.addAttribute("user", userService.findUserByEmail(username));
            model.addAttribute("order", order);
            model.addAttribute("status", OrderStatus.values());
            model.addAttribute("CANCEL", OrderStatus.CANCEL);
            model.addAttribute("action", "updateorderstatus");
            return "admin/orderstatusForm";
        } else {
            return "redirect:admin/home?type=error&message=Not found product id: " + orderId;
        }
    }

    @RequestMapping(value = "/updateorderstatus/{orderId}", method = RequestMethod.POST)
    public String updateOrderStatus(Model model,
            HttpServletRequest request, @PathVariable("orderId") int orderId,
            @ModelAttribute("order") OrderEntity order
    ) {
        OrderEntity changestatus = orderService.findOrderById(orderId);
        changestatus.setStatus(order.getStatus());
        orderService.save(changestatus);
        return "redirect:/admin/listAdOrder";
    }

    @RequestMapping("/cancelOrder/{orderId}")
    public String cancelOrder(Model model, @PathVariable("orderId") int orderId) throws UnsupportedEncodingException, MessagingException {
        String username = UserUtils.User();
        UserEntity user = userService.findUserByEmail(username);
        OrderEntity order = orderService.findOrderById(orderId);
        if (order.getStatus().equals(OrderStatus.CONFIRM)) {
            order.setStatus(OrderStatus.CANCEL);
            List<OrderDetailEntity> orderDetails = orderDetailService.ordersDetails(orderId);
            for (OrderDetailEntity orderDetail : orderDetails) {
                ProductEntity product = productService.findById(orderDetail.getProduct().getId());
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
            model.addAttribute("message", "success");
        } else {
            model.addAttribute("message", "error");
        }
        model.addAttribute("orderDetail", orderDetailService.getOrderDetails());
        model.addAttribute("orders", orderService.findByUserId(user.getId()));
        model.addAttribute("categories", categoryService.getCategories());
        return "redirect:/admin/listAdOrder";
    }

    @RequestMapping("/export/pdf")
    public void exportToPDF(HttpServletResponse response) throws DocumentException, IOException {
        response.setContentType("application/pdf");
        DateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
        String currentDateTime = dateFormatter.format(new Date());

        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=orders_" + currentDateTime + ".pdf";
        response.setHeader(headerKey, headerValue);

        List<OrderEntity> listOrders = orderService.getAllOrders();

        OrderPDFExporter1 exporter = new OrderPDFExporter1(listOrders);
        exporter.export(response);

    }

    public List<String> uploadFile(HttpServletRequest request, @RequestParam("file") MultipartFile[] files) {
        List<String> fileList = new ArrayList<>();
        if (files != null && files.length > 0) {

            for (int i = 0; i < files.length; i++) {
                MultipartFile file = files[i];
                try {
                    byte[] bytes = file.getBytes();

                    ServletContext context = request.getServletContext();
                    String pathUrl = context.getRealPath("/images");

                    int index = pathUrl.indexOf("target");
                    String pathFolder = pathUrl.substring(0, index) + "src\\main\\webapp\\resources\\img\\logo\\";
                    Path path = Paths.get(pathFolder + file.getOriginalFilename());
                    Files.write(path, bytes);

                    // sau khi upload file xong lấy file name ra để insert vào database
                    String name = file.getOriginalFilename();
                    fileList.add(name);
                } catch (Exception e) {
                    System.out.println(e);
                }
            }

        }
        return fileList;

    }

    public List<String> uploadFileProduct(HttpServletRequest request, @RequestParam("file") MultipartFile[] files) {
        List<String> fileList = new ArrayList<>();
        if (files != null && files.length > 0) {

            for (int i = 0; i < files.length; i++) {
                MultipartFile file = files[i];
                try {
                    byte[] bytes = file.getBytes();

                    ServletContext context = request.getServletContext();
                    String pathUrl = context.getRealPath("/images");

                    int index = pathUrl.indexOf("target");
                    String pathFolder = pathUrl.substring(0, index) + "src\\main\\webapp\\resources\\img\\category\\";
                    Path path = Paths.get(pathFolder + file.getOriginalFilename());
                    Files.write(path, bytes);

                    // sau khi upload file xong lấy file name ra để insert vào database
                    String name = file.getOriginalFilename();
                    fileList.add(name);
                } catch (Exception e) {
                    System.out.println(e);
                }
            }

        }
        return fileList;

    }
}
