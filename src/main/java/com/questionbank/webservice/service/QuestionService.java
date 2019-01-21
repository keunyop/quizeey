package com.questionbank.webservice.service;

import org.springframework.stereotype.Service;

import com.questionbank.webservice.domain.question.Question;
import com.questionbank.webservice.domain.question.QuestionRepository;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class QuestionService {
    private QuestionRepository questionRepository;

    public Question getRandomQuestion() {
        return questionRepository.getRandomQuestionFromFile();
    }
}
