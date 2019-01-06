package io.tracking.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/client")
public class PublicController {
	
	@RequestMapping(value="/couriers", method=RequestMethod.GET)
	public String couriers(ModelMap model) {
		System.out.println("shit");
		return "couriers";
	}
	
	@RequestMapping(value="/trackings", method=RequestMethod.GET)
	public String trackings(ModelMap model) {
		System.out.println("shit");
		return "trackings";
	}
}
