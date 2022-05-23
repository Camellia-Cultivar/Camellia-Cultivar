package com.camellia.models.cultivars;

import lombok.Data;

@Data
public class CultivarDenominationDTO {
    private Long cultivarId;
    private String denomination;

    public Long getCultivarId() {
        return cultivarId;
    }

    public void setCultivarId(Long cultivarId) {
        this.cultivarId = cultivarId;
    }

    public String getDenomination() {
        return denomination;
    }

    public void setDenomination(String denomination) {
        this.denomination = denomination;
    }
}
