package com.dipaksarpane.kiln.controller;

import com.dipaksarpane.kiln.service.SystemSettingService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

    private final SystemSettingService systemSettingService;

    public GlobalControllerAdvice(SystemSettingService systemSettingService) {
        this.systemSettingService = systemSettingService;
    }

    @ModelAttribute
    public void addGlobalAttributes(Model model) {
        model.addAttribute("settings", systemSettingService.getSettingsMap());
    }
}
