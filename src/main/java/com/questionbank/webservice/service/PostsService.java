package com.questionbank.webservice.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.questionbank.webservice.domain.posts.PostsRepository;
import com.questionbank.webservice.dto.posts.PostsSaveRequestDto;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class PostsService {
	private PostsRepository postsRepository;
	
	@Transactional
	public Long save(PostsSaveRequestDto dto) {
		return postsRepository.save(dto.toEntity()).getId();
	}
}
