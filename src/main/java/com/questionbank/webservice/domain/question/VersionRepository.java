package com.questionbank.webservice.domain.question;

import java.util.stream.Stream;

import org.springframework.data.jpa.repository.JpaRepository;

public interface VersionRepository extends JpaRepository<Version, Long> {
    Stream<Version> getVersionsByTestId(Long testId);

    Version getVersionByTestIdAndVerNbr(Long testId, int verNbr);

    Version findFirstByTestIdOrderByVerNbr(Long testId);
}
