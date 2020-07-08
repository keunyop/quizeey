package com.questionbank.webservice.service;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.questionbank.webservice.domain.question.Version;
import com.questionbank.webservice.domain.question.VersionRepository;
import com.questionbank.webservice.dto.question.VersionResponseDto;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class VersionService {
    private VersionRepository versionRepository;

    @Transactional(readOnly = true)
    public List<VersionResponseDto> getVersions(Long testId) {
        // Version 목록 조회
        Stream<Version> versions = versionRepository.getVersionsByTestIdOrderByVerNmDesc(testId);
        return versions.map(VersionResponseDto::new).collect(Collectors.toList());
    }
}