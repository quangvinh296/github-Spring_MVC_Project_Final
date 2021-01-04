package com.mycompany.spring_mvc_project_final.entities;

import java.io.Serializable;
import java.util.Set;
import javax.persistence.CascadeType;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name = "credit_card", uniqueConstraints = @UniqueConstraint(columnNames = "cardnumber"))
public class CreditCardEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "card_id")
    private int cardId;
    
    @Column(name = "cardnumber")
    private String cardNumber;

    @Column(name = "ownername")
    private String ownerName;

    @Column(name = "expirymonth")
    private int expiryMonth;

    @Column(name = "expiryyear")
    private int expiryYear;

    @Column(name = "cvv_code")
    private int cvvcode;

    private double balance;

    @OneToMany(mappedBy = "creditcard", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Set<PaymentEntity> payments;

 
    public CreditCardEntity() {
        super();
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    public int getExpiryMonth() {
        return expiryMonth;
    }

    public void setExpiryMonth(int expiryMonth) {
        this.expiryMonth = expiryMonth;
    }

    public int getExpiryYear() {
        return expiryYear;
    }

    public void setExpiryYear(int expiryYear) {
        this.expiryYear = expiryYear;
    }

    public int getCvvcode() {
        return cvvcode;
    }

    public void setCvvcode(int cvvcode) {
        this.cvvcode = cvvcode;
    }

    public int getCardId() {
        return cardId;
    }

    public void setCardId(int cardId) {
        this.cardId = cardId;
    }

    public Set<PaymentEntity> getPayments() {
        return payments;
    }

    public void setPayments(Set<PaymentEntity> payments) {
        this.payments = payments;
    }

   
    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

}
