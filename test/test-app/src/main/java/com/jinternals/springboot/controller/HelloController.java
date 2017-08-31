package com.jinternals.springboot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HelloController {

	@RequestMapping("/")
	String home(ModelMap modal) {
		modal.addAttribute("title", "Spring boot s2i test");
		modal.addAttribute("message", "you seems rocking");
		return "hello";
	}
}
