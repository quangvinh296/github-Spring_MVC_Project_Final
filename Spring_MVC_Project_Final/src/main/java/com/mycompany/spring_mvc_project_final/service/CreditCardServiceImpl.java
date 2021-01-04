/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.CreditCardEntity;
import com.mycompany.spring_mvc_project_final.repository.CreditCardRepository;
import java.util.Optional;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author my
 */
@Service
@Transactional
public class CreditCardServiceImpl {

    @Autowired
    private CreditCardRepository creditCardRepository;
    
   
	public CreditCardEntity getCreditCard(String number) {
		return creditCardRepository.findByCardNumber(number);
	}

        public Optional<CreditCardEntity> getCreditCard(int idCard) {
		return creditCardRepository.findById(idCard);
	}
	
        public CreditCardEntity findCardById(int cardId) {
        Optional<CreditCardEntity> card = creditCardRepository.findById(cardId);
        if (card.isPresent()) {
            return card.get();
        } else {
            return new CreditCardEntity();
        }
    }
        
	public void saveCard(CreditCardEntity creditCard) {
		creditCardRepository.save(creditCard);
	}

}
