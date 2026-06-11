package com.dipaksarpane.kiln.service;

import com.dipaksarpane.kiln.entity.SystemSetting;
import com.dipaksarpane.kiln.repository.SystemSettingRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class SystemSettingService {

    private final SystemSettingRepository settingRepository;

    public SystemSettingService(SystemSettingRepository settingRepository) {
        this.settingRepository = settingRepository;
    }

    public List<SystemSetting> getAllSettings() {
        return settingRepository.findAll();
    }

    public Map<String, String> getSettingsMap() {
        Map<String, String> map = new HashMap<>();
        for (SystemSetting setting : settingRepository.findAll()) {
            map.put(setting.getSettingKey(), setting.getSettingValue());
        }
        return map;
    }

    public String getSetting(String key, String defaultValue) {
        return settingRepository.findById(key)
                .map(SystemSetting::getSettingValue)
                .orElse(defaultValue);
    }

    public void updateSetting(String key, String value) {
        settingRepository.save(new SystemSetting(key, value));
    }

    public BigDecimal getGstRate() {
        try {
            String val = getSetting("GST_RATE", "12");
            return new BigDecimal(val).divide(BigDecimal.valueOf(100)); // returns 0.12
        } catch (Exception e) {
            return BigDecimal.valueOf(0.12);
        }
    }

    public BigDecimal getGstRatePercent() {
        try {
            String val = getSetting("GST_RATE", "12");
            return new BigDecimal(val); // returns 12
        } catch (Exception e) {
            return BigDecimal.valueOf(12);
        }
    }

    public BigDecimal getTransportRateStandard() {
        try {
            String val = getSetting("TRANSPORT_RATE_STANDARD", "1.50");
            return new BigDecimal(val);
        } catch (Exception e) {
            return BigDecimal.valueOf(1.50);
        }
    }

    public BigDecimal getTransportRateHollow() {
        try {
            String val = getSetting("TRANSPORT_RATE_HOLLOW", "5.00");
            return new BigDecimal(val);
        } catch (Exception e) {
            return BigDecimal.valueOf(5.00);
        }
    }

    public BigDecimal getTransportLocal() {
        try {
            String val = getSetting("TRANSPORT_LOCAL", "0");
            return new BigDecimal(val);
        } catch (Exception e) {
            return BigDecimal.ZERO;
        }
    }

    public BigDecimal getTransportParanda() {
        try {
            String val = getSetting("TRANSPORT_PARANDA", "1500");
            return new BigDecimal(val);
        } catch (Exception e) {
            return BigDecimal.valueOf(1500);
        }
    }

    public BigDecimal getTransportDharashiv() {
        try {
            String val = getSetting("TRANSPORT_DHARASHIV", "3500");
            return new BigDecimal(val);
        } catch (Exception e) {
            return BigDecimal.valueOf(3500);
        }
    }

    public BigDecimal getTransportLong() {
        try {
            String val = getSetting("TRANSPORT_LONG", "5000");
            return new BigDecimal(val);
        } catch (Exception e) {
            return BigDecimal.valueOf(5000);
        }
    }
}
