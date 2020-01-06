package com.questionbank.webservice.domain.question;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface TestRepository extends JpaRepository<Test, Long> {
    List<Test> findByTestNmNotNullOrderByInqrSeq();

    List<Test> findByTestNmEngNotNullOrderByInqrSeq();

    Test findFirstByOrderByTestIdDesc();

    boolean existsByTestNm(String testNm);

    Test findByTestNm(String testNm);

}
